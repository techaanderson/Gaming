# Install Peak Unlimited Mods Script
# https://github.com/glarmer/PEAK-Unlimited/

<#
1. Download Bepinex from https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.3/BepInEx_win_x64_5.4.23.3.zip
2. Extract the contents of that zip into your game directory (default: C:\Program Files (x86)\Steam\steamapps\common\PEAK)
3. Start the game and close it again, this does the first time set up for Bepinex.
4. Navigate to ...\PEAK\BepInEx\plugins, copy and paste the PeakUnlimited.dll from PEAK Unlimited releases into this folder.
5. Run the game
#>

#--------------- Variables ------------------------------------------------------------------------------------------------------------------------------------#

# Define the game directories
$installDir = "F:\Games\Steam_Games\steamapps\common\PEAK\"
$pluginsFolderPath = Join-Path -Path $installDir -ChildPath "BepInEx\plugins\"
# Get the user's Downloads folder path
$downloadsFolderPath = Get-ItemPropertyValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "{374DE290-123F-4565-9164-39C4925E467B}"

#--------------- Bepinex --------------------------------------------------------------------------------------------------------------------------------------#
# Download Bepinex from GitHub and extract to your game directory
$GitHubApiUrl = "https://api.github.com/repos/BepInEx/BepInEx/releases/latest"
$downloadUrl = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.browser_download_url | Where-Object {$_ -like '*win_x86*'}
$downloadName = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.name | Where-Object {$_ -like '*win_x86*'}
$FilePath = Join-Path -Path $downloadsFolderPath -ChildPath $downloadName
Invoke-WebRequest -Uri $downloadUrl -OutFile $FilePath
Expand-Archive -Path $zipFilePath -DestinationPath $installDir -Force

#---------------- PEAK Unlimited ------------------------------------------------------------------------------------------------------------------------------#
# Download PEAK Unlimited from GitHub and extract to your game plugins directory
$GitHubApiUrl = "https://api.github.com/repos/glarmer/PEAK-Unlimited/releases/latest"
$downloadUrl = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.browser_download_url | Where-Object {$_ -like '*PEAK-Unlimited*'}
$downloadName = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.name
$FilePath = Join-Path -Path $downloadsFolderPath -ChildPath $downloadName
Invoke-WebRequest -Uri $downloadUrl -OutFile $FilePath
Copy-Item -Path $FilePath -DestinationPath $pluginsFolderPath -Force