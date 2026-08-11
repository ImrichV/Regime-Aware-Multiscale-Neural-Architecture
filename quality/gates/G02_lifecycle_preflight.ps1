[CmdletBinding()]
param(
    [string]$EvidencePath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path
if (-not $EvidencePath) {
    $EvidencePath = Join-Path $projectRoot 'quality\evidence\lifecycle_preflight.latest.json'
}

$g00Path = Join-Path $projectRoot 'quality\gates\G00_governance_preflight.ps1'
$lifecyclePath = Join-Path $projectRoot 'architecture\CANONICAL_SYSTEM_LIFECYCLE.md'
$agentsPath = Join-Path $projectRoot 'AGENTS.md'
$statePath = Join-Path $projectRoot 'SYSTEM_STATE.md'
$workflowPath = Join-Path $projectRoot '.github\workflows\quality-preflight.yml'
$checks = [System.Collections.Generic.List[object]]::new()

function Add-Check {
    param([string]$Id, [bool]$Passed, [string]$Detail)
    $checks.Add([pscustomobject]@{
        id = $Id
        status = if ($Passed) { 'PASS' } else { 'FAIL' }
        detail = $Detail
    })
}

& $g00Path | ForEach-Object { Write-Output $_ }
Add-Check -Id 'G00_GOVERNANCE' -Passed $true -Detail 'G00 completed successfully.'

foreach ($required in @($lifecyclePath, $agentsPath, $statePath, $workflowPath)) {
    $name = $required.Substring($projectRoot.Length).TrimStart('\').Replace('\', '_').Replace('.', '_').ToUpperInvariant()
    Add-Check -Id ('FILE_' + $name) -Passed (Test-Path -LiteralPath $required -PathType Leaf) -Detail $required
}

$requiredFilesPresent = @($checks | Where-Object { $_.id -like 'FILE_*' -and $_.status -eq 'FAIL' }).Count -eq 0
$approvedLifecycleHash = $null
$actualLifecycleHash = $null
$lifecycleVersion = $null

if ($requiredFilesPresent) {
    $lifecycleText = Get-Content -LiteralPath $lifecyclePath -Raw
    $agentsText = Get-Content -LiteralPath $agentsPath -Raw
    $stateText = Get-Content -LiteralPath $statePath -Raw
    $workflowText = Get-Content -LiteralPath $workflowPath -Raw

    $hashMatch = [regex]::Match($stateText, 'Approved lifecycle SHA-256:\s+`([A-Fa-f0-9]{64})`')
    if ($hashMatch.Success) {
        $approvedLifecycleHash = $hashMatch.Groups[1].Value.ToUpperInvariant()
        Add-Check -Id 'STATE_APPROVED_LIFECYCLE_HASH_DECLARED' -Passed $true -Detail $approvedLifecycleHash
    }
    else {
        Add-Check -Id 'STATE_APPROVED_LIFECYCLE_HASH_DECLARED' -Passed $false -Detail 'SYSTEM_STATE.md does not contain one parseable approved lifecycle SHA-256.'
    }

    $actualLifecycleHash = (Get-FileHash -LiteralPath $lifecyclePath -Algorithm SHA256).Hash.ToUpperInvariant()
    Add-Check -Id 'LIFECYCLE_HASH_MATCH' -Passed ($approvedLifecycleHash -and $actualLifecycleHash -eq $approvedLifecycleHash) -Detail "approved=$approvedLifecycleHash actual=$actualLifecycleHash"

    $versionMatch = [regex]::Match($lifecycleText, 'Lifecycle version:\s+\*\*(CSL v[0-9]+\.[0-9]+)\*\*')
    if ($versionMatch.Success) {
        $lifecycleVersion = $versionMatch.Groups[1].Value
        Add-Check -Id 'LIFECYCLE_VERSION_DECLARED' -Passed ($lifecycleVersion -eq 'CSL v0.1') -Detail $lifecycleVersion
    }
    else {
        Add-Check -Id 'LIFECYCLE_VERSION_DECLARED' -Passed $false -Detail 'Lifecycle version is missing or malformed.'
    }

    foreach ($marker in @(
        'Status: **ACTIVE GOVERNING BASELINE**',
        '## 4. Canonical lifecycle map',
        '## 5. Lifecycle stages',
        '## 6. Canonical boundaries',
        '## 7. Universal boundary contract',
        '## 8. Lifecycle Impact Declaration',
        '## 9. Definition of done',
        '## 10. Change and invalidation rule',
        '## 11. Authorization matrix',
        '## 13. Fail-closed and Occam rule'
    )) {
        $id = ($marker -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()
        Add-Check -Id ('LIFECYCLE_CONTAINS_' + $id) -Passed $lifecycleText.Contains($marker) -Detail $marker
    }

    foreach ($number in 0..17) {
        $stageId = 'L{0:d2}' -f $number
        $rowPattern = '(?m)^\| `' + $stageId + '` \|'
        $count = [regex]::Matches($lifecycleText, $rowPattern).Count
        Add-Check -Id ('STAGE_' + $stageId + '_EXACTLY_ONCE') -Passed ($count -eq 1) -Detail "$stageId stage_rows=$count"
    }

    foreach ($number in 0..17) {
        $boundaryId = 'B{0:d2}' -f $number
        $rowPattern = '(?m)^\| `' + $boundaryId + '` \|'
        $count = [regex]::Matches($lifecycleText, $rowPattern).Count
        Add-Check -Id ('BOUNDARY_' + $boundaryId + '_EXACTLY_ONCE') -Passed ($count -eq 1) -Detail "$boundaryId boundary_rows=$count"
    }

    foreach ($requiredInstruction in @(
        'architecture/CANONICAL_SYSTEM_LIFECYCLE.md',
        'G02_lifecycle_preflight.ps1',
        'Lifecycle Impact Declaration',
        'L00`-`L17',
        'B00`-`B17',
        'final lifecycle coherence statement',
        'STALE',
        'REVALIDATION REQUIRED'
    )) {
        $id = ($requiredInstruction -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()
        Add-Check -Id ('AGENTS_CONTAINS_' + $id) -Passed $agentsText.Contains($requiredInstruction) -Detail $requiredInstruction
    }

    Add-Check -Id 'STATE_LIFECYCLE_ACTIVE' -Passed $stateText.Contains('| Canonical system lifecycle CSL v0.1 | ACTIVE |') -Detail 'SYSTEM_STATE declares CSL v0.1 ACTIVE.'
    Add-Check -Id 'STATE_ARCHITECTURE_NOT_DESIGNED' -Passed $stateText.Contains('| Neural architecture | NOT DESIGNED |') -Detail 'Lifecycle activation does not falsely approve a neural architecture.'
    Add-Check -Id 'WORKFLOW_RUNS_G00' -Passed $workflowText.Contains('G00_governance_preflight.ps1') -Detail 'GitHub workflow invokes G00.'
    Add-Check -Id 'WORKFLOW_RUNS_G01' -Passed $workflowText.Contains('G01_publication_preflight.ps1') -Detail 'GitHub workflow invokes G01.'
    Add-Check -Id 'WORKFLOW_RUNS_G02' -Passed $workflowText.Contains('G02_lifecycle_preflight.ps1') -Detail 'GitHub workflow invokes G02.'
}

$overallStatus = if (@($checks | Where-Object { $_.status -eq 'FAIL' }).Count -eq 0) { 'PASS' } else { 'FAIL' }
$record = [ordered]@{
    gate_id = 'G02'
    gate_name = 'Canonical lifecycle enforcement preflight'
    protocol_version = 'MQVRIP v0.1'
    lifecycle_version = $lifecycleVersion
    timestamp_utc = [DateTime]::UtcNow.ToString('o')
    project_root = $projectRoot
    status = $overallStatus
    approved_lifecycle_sha256 = $approvedLifecycleHash
    actual_lifecycle_sha256 = $actualLifecycleHash
    stage_count_expected = 18
    boundary_count_expected = 18
    checks = $checks
}

$evidenceDirectory = Split-Path -Parent $EvidencePath
New-Item -ItemType Directory -Force -Path $evidenceDirectory | Out-Null
$temporaryEvidence = $EvidencePath + '.tmp'
$record | ConvertTo-Json -Depth 7 | Set-Content -LiteralPath $temporaryEvidence -Encoding UTF8
Move-Item -LiteralPath $temporaryEvidence -Destination $EvidencePath -Force

Write-Output "G02 LIFECYCLE PREFLIGHT: $overallStatus"
foreach ($check in $checks) {
    Write-Output ("{0} {1}: {2}" -f $check.status, $check.id, $check.detail)
}
Write-Output "Evidence: $EvidencePath"

if ($overallStatus -ne 'PASS') {
    throw 'Lifecycle preflight failed. Do not continue material project work until failures are resolved.'
}

