$ErrorActionPreference = 'Stop'
$logPath = Join-Path $env:LOCALAPPDATA 'EndfieldModLoader\modules\host.log'
if (-not (Test-Path -LiteralPath $logPath)) { throw "EML host.log not found: $logPath" }
$destination = Join-Path $PSScriptRoot ('Q3-Diagnostics-' + (Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
New-Item -ItemType Directory -Path $destination | Out-Null
$lines = Get-Content -LiteralPath $logPath -Tail 12000 -Encoding UTF8
$filtered = @($lines | Where-Object { $_ -match 'quest3\.vrvd|VR frame diagnostic:|example\.first-person|EFVR_FirstPerson' })
# Never copy the EML index/config or arbitrary log files. Redact token-like values defensively.
$redacted = $filtered | ForEach-Object { $_ -replace '(?i)("?(?:token|authorization|password|secret)"?\s*[:=]\s*)"?[^",\s}]+"?', '$1[REDACTED]' }
$redacted | Set-Content -LiteralPath (Join-Path $destination 'module-log.txt') -Encoding UTF8
@{
    package = '0.6.9-smooth-popup'
    collected_at = (Get-Date).ToString('o')
    matched_lines = $filtered.Count
    game_started_by_collector = $false
    note = 'Log-only collection. Copy the EML VR page diagnostic separately for current state. No upload.'
} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $destination 'collection.json') -Encoding UTF8
Write-Host "Saved diagnostics: $destination"
Write-Host 'Also include the VR page diagnostic and whether the desktop game menu is visible.'
