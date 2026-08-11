[CmdletBinding()]
param(
    [string]$ManifestPath,
    [string]$EvidencePath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path
$allowlistPath = Join-Path $projectRoot 'quality\publication\approved_paths.txt'
$g00Path = Join-Path $projectRoot 'quality\gates\G00_governance_preflight.ps1'

if (-not $ManifestPath) {
    $ManifestPath = Join-Path $projectRoot 'PUBLICATION_MANIFEST.json'
}
if (-not $EvidencePath) {
    $EvidencePath = Join-Path $projectRoot 'quality\evidence\publication_preflight.latest.json'
}

$checks = [System.Collections.Generic.List[object]]::new()
$fileRecords = [System.Collections.Generic.List[object]]::new()
$maximumFileBytes = 1MB
$maximumTotalBytes = 5MB
$allowedExtensions = @('.md', '.ps1', '.txt', '.json', '.yaml', '.yml', '.toml')
$forbiddenSegments = @('.env', '.venv', 'data', 'datasets', 'logs', 'checkpoints', 'models', 'weights', 'cache', 'tmp', 'temp', 'secrets')

function Add-Check {
    param([string]$Id, [bool]$Passed, [string]$Detail)
    $checks.Add([pscustomobject]@{
        id = $Id
        status = if ($Passed) { 'PASS' } else { 'FAIL' }
        detail = $Detail
    })
}

function Get-GitBlobSha1 {
    param([byte[]]$Content)
    $header = [Text.Encoding]::UTF8.GetBytes("blob $($Content.Length)`0")
    $combined = New-Object byte[] ($header.Length + $Content.Length)
    [Array]::Copy($header, 0, $combined, 0, $header.Length)
    [Array]::Copy($Content, 0, $combined, $header.Length, $Content.Length)
    $sha1 = [Security.Cryptography.SHA1]::Create()
    try {
        return ([BitConverter]::ToString($sha1.ComputeHash($combined)) -replace '-', '').ToLowerInvariant()
    }
    finally {
        $sha1.Dispose()
    }
}

function Find-PublicationRisk {
    param([string]$Text)

    $privateKeyPattern = '-----BEGIN ' + '(?:RSA |EC |OPENSSH )?' + 'PRIVATE KEY-----'
    $patterns = @(
        @{ name = 'private-key material'; regex = $privateKeyPattern },
        @{ name = 'GitHub-style access token'; regex = '(?<![A-Za-z0-9])gh[pousr]_[A-Za-z0-9]{30,}' },
        @{ name = 'AWS-style access key'; regex = '(?<![A-Z0-9])AKIA[A-Z0-9]{16}(?![A-Z0-9])' },
        @{ name = 'OpenAI-style secret key'; regex = '(?<![A-Za-z0-9])sk-[A-Za-z0-9_-]{20,}' },
        @{ name = 'credential assignment'; regex = '(?i)(api[_-]?key|password|secret|access[_-]?token)\s*[:=]\s*["''][^"'']{8,}["'']' },
        @{ name = 'credential-bearing database URL'; regex = '(?i)(postgres|postgresql|mysql|mongodb(?:\+srv)?)://[^\s/:]+:[^\s/@]+@' },
        @{ name = 'absolute Windows user path'; regex = '(?i)[A-Z]:\\Users\\[^\\\s]+' }
    )

    foreach ($pattern in $patterns) {
        if ([regex]::IsMatch($Text, $pattern.regex)) {
            return $pattern.name
        }
    }
    return $null
}

& $g00Path | ForEach-Object { Write-Output $_ }
Add-Check -Id 'G00_GOVERNANCE' -Passed $true -Detail 'G00 completed successfully.'

Add-Check -Id 'ALLOWLIST_EXISTS' -Passed (Test-Path -LiteralPath $allowlistPath -PathType Leaf) -Detail $allowlistPath
if (-not (Test-Path -LiteralPath $allowlistPath -PathType Leaf)) {
    throw 'Publication allowlist is missing.'
}

$approvedPaths = @(Get-Content -LiteralPath $allowlistPath | ForEach-Object { $_.Trim() } | Where-Object { $_ -and -not $_.StartsWith('#') })
$duplicates = @($approvedPaths | Group-Object | Where-Object { $_.Count -gt 1 })
$duplicateDetail = if ($duplicates.Count) { $duplicates.Name -join ', ' } else { 'No duplicate paths.' }
Add-Check -Id 'ALLOWLIST_UNIQUE' -Passed ($duplicates.Count -eq 0) -Detail $duplicateDetail

$totalBytes = 0L
foreach ($relativePath in $approvedPaths) {
    $normalized = $relativePath.Replace('\', '/')
    $segments = @($normalized.Split('/') | ForEach-Object { $_.ToLowerInvariant() })
    $unsafeSegment = @($segments | Where-Object { $forbiddenSegments -contains $_ })
    Add-Check -Id ('PATH_ALLOWED_' + ($normalized -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed ($unsafeSegment.Count -eq 0) -Detail $normalized

    $fullPath = Join-Path $projectRoot ($normalized.Replace('/', [IO.Path]::DirectorySeparatorChar))
    $exists = Test-Path -LiteralPath $fullPath -PathType Leaf
    Add-Check -Id ('FILE_EXISTS_' + ($normalized -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed $exists -Detail $normalized
    if (-not $exists) { continue }

    $extension = [IO.Path]::GetExtension($fullPath).ToLowerInvariant()
    $fileName = [IO.Path]::GetFileName($fullPath).ToLowerInvariant()
    $extensionIsAllowed = ($allowedExtensions -contains $extension) -or ($fileName -eq '.gitattributes')
    Add-Check -Id ('EXTENSION_ALLOWED_' + ($normalized -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed $extensionIsAllowed -Detail "$normalized extension=$extension"

    $item = Get-Item -LiteralPath $fullPath
    $totalBytes += $item.Length
    Add-Check -Id ('SIZE_ALLOWED_' + ($normalized -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed ($item.Length -le $maximumFileBytes) -Detail "$normalized bytes=$($item.Length)"

    $bytes = [IO.File]::ReadAllBytes($fullPath)
    $text = [Text.Encoding]::UTF8.GetString($bytes)
    $risk = Find-PublicationRisk -Text $text
    $riskDetail = if ($risk) { "$normalized risk=$risk" } else { $normalized }
    Add-Check -Id ('CONTENT_SAFE_' + ($normalized -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed (-not $risk) -Detail $riskDetail

    $fileRecords.Add([pscustomobject]@{
        path = $normalized
        bytes = $item.Length
        sha256 = (Get-FileHash -LiteralPath $fullPath -Algorithm SHA256).Hash.ToLowerInvariant()
        git_blob_sha1 = Get-GitBlobSha1 -Content $bytes
    })
}

Add-Check -Id 'TOTAL_SIZE_ALLOWED' -Passed ($totalBytes -le $maximumTotalBytes) -Detail "total_bytes=$totalBytes limit=$maximumTotalBytes"
$preManifestFailures = @($checks | Where-Object { $_.status -eq 'FAIL' })

if ($preManifestFailures.Count -eq 0) {
    $manifest = [ordered]@{
        schema_version = 1
        repository = 'ImrichV/Regime-Aware-Multiscale-Neural-Architecture'
        visibility = 'public'
        generated_utc = [DateTime]::UtcNow.ToString('o')
        publication_rule = 'Only listed files plus this manifest are eligible for the controlled GitHub publication.'
        files = @($fileRecords | Sort-Object path)
    }
    $temporaryManifest = $ManifestPath + '.tmp'
    $manifest | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $temporaryManifest -Encoding UTF8
    Move-Item -LiteralPath $temporaryManifest -Destination $ManifestPath -Force
    Add-Check -Id 'MANIFEST_CREATED' -Passed $true -Detail $ManifestPath
}
else {
    Add-Check -Id 'MANIFEST_CREATED' -Passed $false -Detail 'Manifest not created because a prior publication check failed.'
}

$overallStatus = if (@($checks | Where-Object { $_.status -eq 'FAIL' }).Count -eq 0) { 'PASS' } else { 'FAIL' }
$evidence = [ordered]@{
    gate_id = 'G01'
    gate_name = 'Public repository publication preflight'
    timestamp_utc = [DateTime]::UtcNow.ToString('o')
    project_root = $projectRoot
    status = $overallStatus
    repository = 'ImrichV/Regime-Aware-Multiscale-Neural-Architecture'
    approved_file_count = $approvedPaths.Count
    approved_total_bytes = $totalBytes
    manifest_path = $ManifestPath
    checks = $checks
}

$evidenceDirectory = Split-Path -Parent $EvidencePath
New-Item -ItemType Directory -Force -Path $evidenceDirectory | Out-Null
$temporaryEvidence = $EvidencePath + '.tmp'
$evidence | ConvertTo-Json -Depth 7 | Set-Content -LiteralPath $temporaryEvidence -Encoding UTF8
Move-Item -LiteralPath $temporaryEvidence -Destination $EvidencePath -Force

Write-Output "G01 PUBLICATION PREFLIGHT: $overallStatus"
foreach ($check in $checks) {
    Write-Output ("{0} {1}: {2}" -f $check.status, $check.id, $check.detail)
}
Write-Output "Manifest: $ManifestPath"
Write-Output "Evidence: $EvidencePath"

if ($overallStatus -ne 'PASS') {
    throw 'Public publication preflight failed. Nothing may be uploaded.'
}
