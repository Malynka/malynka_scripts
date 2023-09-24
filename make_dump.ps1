$date = (Get-Date).ToString("dd.MM.yyyy-HH_mm_ss")

$malynkaBasePath = Split-Path $(Split-Path $MyInvocation.MyCommand.Path -Parent) -Parent

$pathToSave = Join-Path -Path $malynkaBasePath -ChildPath "Резервні копії\malynka_db_dump"
$pathToSave += "_"
$pathToSave += $date

mongodump.exe --uri "mongodb://localhost:27017/malynkadb?connect=direct" --out $pathToSave

$archivePath = $pathToSave + ".zip"

Compress-Archive -Path $pathToSave -DestinationPath $archivePath -Update

Remove-Item -Path $pathToSave -Recurse