Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$files = Get-ChildItem -Path . -Filter '*.ps1' -File -Recurse
if (-not $files) {
    Write-Error 'No .ps1 files found'
}

foreach ($file in $files) {
    $text = Get-Content -Raw -Path $file.FullName
    $formatted = Invoke-Formatter -ScriptDefinition $text -Settings CodeFormatting
    if ($formatted.TrimEnd() -ne $text.TrimEnd()) {
        Write-Output "$($file.Name) needs formatting; formatter output:"
        Write-Output $formatted
        exit 1
    }
}

$findings = @()
foreach ($file in $files) {
    $findings += Invoke-ScriptAnalyzer -Path $file.FullName
}
if ($findings) {
    $findings | Format-List RuleName, Severity, ScriptName, Line, Message | Out-String -Width 200 | Write-Output
    exit 1
}
Write-Output 'PowerShell QA clean'
