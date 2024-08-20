param (
    [string]$source,
    [string]$destination,
    [string]$recycleApp,
    [string]$computerName,
    [string]$username,
    [string]$password,
    [string]$delete,
    [string]$skipDirectory
)

$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe"

$computerNameArgument = "$computerName/MsDeploy.axd?site=$recycleApp"
$directory = Get-Location
$contentPath = Join-Path $directory $source

$targetPath = "$recycleApp$destination"

[System.Collections.ArrayList]$msdeployArguments = @(
    "-verb:sync",
    "-allowUntrusted",
    "-source:contentPath=`"$contentPath`"",
    "-dest:contentPath=`"$targetPath`",computerName=`"$computerNameArgument`",username=`"$username`",password=`"$password`",AuthType=Basic"
)

if ($delete -NotMatch "true") {
    $msdeployArguments.Add("-enableRule:DoNotDeleteRule")
}

if ($skipDirectory) {
    $msdeployArguments.Add("-skip:Directory=`"$skipDirectory`"")
}

#$msdeployArguments.Add("-whatIf")
Write-Host "Command: $msdeploy $($msdeployArguments -join ' ')"
& $msdeploy @msdeployArguments

Write-Host "El sitio $recycleApp se ha publicado con exito :)."

