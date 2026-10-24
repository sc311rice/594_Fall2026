$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$tectonic = Join-Path $root 'tectonic.exe'
if (-not (Test-Path $tectonic)) {
    $tectonic = (Get-Command tectonic -ErrorAction SilentlyContinue).Source
}
if (-not $tectonic) {
    throw 'Tectonic was not found. Install Tectonic or place tectonic.exe beside this script.'
}
Push-Location $root
try {
    & $tectonic --keep-logs --keep-intermediates main.tex
    if ($LASTEXITCODE -ne 0) { throw "Tectonic failed with exit code $LASTEXITCODE" }
}
finally {
    Pop-Location
}
