[CmdletBinding()]
param(
    [string]$EvidencePath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path
if (-not $EvidencePath) {
    $EvidencePath = Join-Path $projectRoot 'quality\evidence\governance_preflight.latest.json'
}

$agentsPath = Join-Path $projectRoot 'AGENTS.md'
$protocolPath = Join-Path $projectRoot 'MASTER_QUALITY_PROTOCOL.md'
$statePath = Join-Path $projectRoot 'SYSTEM_STATE.md'
$lifecyclePath = Join-Path $projectRoot 'architecture\CANONICAL_SYSTEM_LIFECYCLE.md'
$lifecycleGatePath = Join-Path $projectRoot 'quality\gates\G02_lifecycle_preflight.ps1'
$workflowPath = Join-Path $projectRoot '.github\workflows\quality-preflight.yml'
$attributesPath = Join-Path $projectRoot '.gitattributes'
$checks = [System.Collections.Generic.List[object]]::new()

function Add-Check {
    param(
        [string]$Id,
        [bool]$Passed,
        [string]$Detail
    )

    $checks.Add([pscustomobject]@{
        id = $Id
        status = if ($Passed) { 'PASS' } else { 'FAIL' }
        detail = $Detail
    })
}

foreach ($required in @($agentsPath, $protocolPath, $statePath, $lifecyclePath, $lifecycleGatePath, $workflowPath, $attributesPath)) {
    Add-Check -Id ('FILE_' + [IO.Path]::GetFileName($required).ToUpperInvariant()) -Passed (Test-Path -LiteralPath $required -PathType Leaf) -Detail $required
}

$requiredFilesPresent = @($checks | Where-Object { $_.id -like 'FILE_*' -and $_.status -eq 'FAIL' }).Count -eq 0
$actualHash = $null
$approvedHash = $null
$actualAgentsHash = $null
$approvedAgentsHash = $null

if ($requiredFilesPresent) {
    $stateText = Get-Content -LiteralPath $statePath -Raw
    $agentsText = Get-Content -LiteralPath $agentsPath -Raw
    $protocolText = Get-Content -LiteralPath $protocolPath -Raw

    $hashMatch = [regex]::Match($stateText, 'Approved protocol SHA-256:\s+`([A-Fa-f0-9]{64})`')
    if ($hashMatch.Success) {
        $approvedHash = $hashMatch.Groups[1].Value.ToUpperInvariant()
        Add-Check -Id 'STATE_APPROVED_HASH_DECLARED' -Passed $true -Detail $approvedHash
    }
    else {
        Add-Check -Id 'STATE_APPROVED_HASH_DECLARED' -Passed $false -Detail 'SYSTEM_STATE.md does not contain one parseable approved SHA-256.'
    }

    $actualHash = (Get-FileHash -LiteralPath $protocolPath -Algorithm SHA256).Hash.ToUpperInvariant()
    Add-Check -Id 'PROTOCOL_HASH_MATCH' -Passed ($approvedHash -and $actualHash -eq $approvedHash) -Detail "approved=$approvedHash actual=$actualHash"

    $agentsHashMatch = [regex]::Match($stateText, 'Approved AGENTS SHA-256:\s+`([A-Fa-f0-9]{64})`')
    if ($agentsHashMatch.Success) {
        $approvedAgentsHash = $agentsHashMatch.Groups[1].Value.ToUpperInvariant()
        Add-Check -Id 'STATE_APPROVED_AGENTS_HASH_DECLARED' -Passed $true -Detail $approvedAgentsHash
    }
    else {
        Add-Check -Id 'STATE_APPROVED_AGENTS_HASH_DECLARED' -Passed $false -Detail 'SYSTEM_STATE.md does not contain one parseable approved AGENTS SHA-256.'
    }

    $actualAgentsHash = (Get-FileHash -LiteralPath $agentsPath -Algorithm SHA256).Hash.ToUpperInvariant()
    Add-Check -Id 'AGENTS_HASH_MATCH' -Passed ($approvedAgentsHash -and $actualAgentsHash -eq $approvedAgentsHash) -Detail "approved=$approvedAgentsHash actual=$actualAgentsHash"

    foreach ($requiredInstruction in @(
        'MASTER_QUALITY_PROTOCOL.md',
        'architecture/CANONICAL_SYSTEM_LIFECYCLE.md',
        'SYSTEM_STATE.md',
        'G02_lifecycle_preflight.ps1',
        'Lifecycle Impact Declaration',
        'Never bypass, weaken, relabel, or silently ignore a failed hard gate',
        'System Coherence Gate',
        'STALE',
        'governance preflight'
    )) {
        Add-Check -Id ('AGENTS_CONTAINS_' + ($requiredInstruction -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed $agentsText.Contains($requiredInstruction) -Detail $requiredInstruction
    }

    foreach ($requiredProtocolMarker in @(
        '# TRADING NEURAL SYSTEM',
        '# 2. OCCAM + SYSTEM COHERENCE RULE',
        '# 75. THE MOST IMPORTANT HARD GATES',
        '# 77. MASTER RULE'
    )) {
        Add-Check -Id ('PROTOCOL_CONTAINS_' + ($requiredProtocolMarker -replace '[^A-Za-z0-9]+', '_').Trim('_').ToUpperInvariant()) -Passed $protocolText.Contains($requiredProtocolMarker) -Detail $requiredProtocolMarker
    }

    Add-Check -Id 'STATE_GOVERNANCE_ACTIVE' -Passed $stateText.Contains('Overall governance status: ACTIVE') -Detail 'SYSTEM_STATE declares governance ACTIVE.'
    Add-Check -Id 'STATE_TRAINING_DENIED' -Passed $stateText.Contains('Training authorization | DENIED') -Detail 'Training remains denied until later gates pass.'
    Add-Check -Id 'STATE_PRODUCTION_DENIED' -Passed $stateText.Contains('Production eligibility | DENIED') -Detail 'Production remains denied until later gates pass.'
}

$overallStatus = if (@($checks | Where-Object { $_.status -eq 'FAIL' }).Count -eq 0) { 'PASS' } else { 'FAIL' }
$record = [ordered]@{
    gate_id = 'G00'
    gate_name = 'Governance foundation preflight'
    protocol_version = 'MQVRIP v0.1'
    timestamp_utc = [DateTime]::UtcNow.ToString('o')
    project_root = $projectRoot
    status = $overallStatus
    approved_protocol_sha256 = $approvedHash
    actual_protocol_sha256 = $actualHash
    approved_agents_sha256 = $approvedAgentsHash
    actual_agents_sha256 = $actualAgentsHash
    checks = $checks
}

$evidenceDirectory = Split-Path -Parent $EvidencePath
New-Item -ItemType Directory -Force -Path $evidenceDirectory | Out-Null
$temporaryEvidence = $EvidencePath + '.tmp'
$record | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $temporaryEvidence -Encoding UTF8
Move-Item -LiteralPath $temporaryEvidence -Destination $EvidencePath -Force

Write-Output "G00 GOVERNANCE PREFLIGHT: $overallStatus"
foreach ($check in $checks) {
    Write-Output ("{0} {1}: {2}" -f $check.status, $check.id, $check.detail)
}
Write-Output "Evidence: $EvidencePath"

if ($overallStatus -ne 'PASS') {
    throw 'Governance preflight failed. Do not continue substantive project work until failures are resolved.'
}
