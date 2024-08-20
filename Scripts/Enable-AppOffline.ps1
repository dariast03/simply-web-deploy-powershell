param (
    [string]$destination,
    [string]$recycleApp,
    [string]$computerName,
    [string]$username,
    [string]$password,
    [string]$appOfflineFilePath = "C:\inetpub\wwwroot\App_Offline.template.htm"
)

$msdeploy = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe"
$computerNameArgument = "$computerName/MsDeploy.axd?site=$recycleApp"

$targetPath = "$recycleApp$destination"

[System.Collections.ArrayList]$msdeployArguments = @(
    "-verb:sync",
    "-allowUntrusted",
    "-source:contentPath=`"$appOfflineFilePath`"",
    "-dest:contentPath=`"$targetPath\app_offline.htm`",computerName=`"$computerNameArgument`",username=`"$username`",password=`"$password`",AuthType=Basic"
)

#$msdeployArguments.Add("-whatIf")
#Write-Host "$msdeploy $($msdeployArguments -join ' ')"
& $msdeploy @msdeployArguments
Write-Host "El sitio $recycleApp se encuentra en modo offline."
