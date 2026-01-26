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
$installDir = "D:\Games\Steam_Games\steamapps\common\PEAK\"
$pluginsFolderPath = Join-Path -Path $installDir -ChildPath "BepInEx\plugins\"

#--------------- Bepinex --------------------------------------------------------------------------------------------------------------------------------------#
# Download Bepinex from GitHub and extract to your game directory
$GitHubApiUrl = "https://api.github.com/repos/BepInEx/BepInEx/releases/latest"
$downloadUrl = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.browser_download_url | Where-Object { $_ -like '*win_x86*' }
$downloadName = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.name | Where-Object { $_ -like '*win_x86*' }
$zipFilePath = Join-Path -Path $installDir -ChildPath $downloadName
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath
Expand-Archive -Path $zipFilePath -DestinationPath $installDir -Force

#---------------- PEAK Unlimited ------------------------------------------------------------------------------------------------------------------------------#
# Chcck if plugins folder exists, if not stop the script and inform the user to start the game once
if (-Not (Test-Path -Path $pluginsFolderPath)) {
    Write-Host "Plugins folder not found. Please start the game once to set up BepInEx, then run this script again." -ForegroundColor Red
    exit
}
else {
    # Download PEAK Unlimited dll from GitHub to your game plugins directory
    $GitHubApiUrl = "https://api.github.com/repos/glarmer/PEAK-Unlimited/releases/latest"
    $downloadUrl = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.browser_download_url | Where-Object { $_ -like '*PEAK-Unlimited*' }
    $downloadName = (Invoke-RestMethod -uri  $GitHubApiUrl)[0].assets.name
    $FilePath = Join-Path -Path $pluginsFolderPath -ChildPath $downloadName
    Invoke-WebRequest -Uri $downloadUrl -OutFile $FilePath
}