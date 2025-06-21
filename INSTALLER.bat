@echo off
setlocal

:: === CONFIG ===
set "GORILLA_TAG_PATH=C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag"
set "BEPINEX_URL=https://github.com/BepInEx/BepInEx/releases/download/v5.4.21/BepInEx_x64_5.4.21.0.zip"
set "MODMENU_URL=https://github.com/LILmonster9285/M0NSTERMENU/releases/download/v1.0.0/M0NSTERMENU.dll"

:: === PREP ===
echo Installing M0NSTERMENU and BepInEx...
cd /d "%~dp0"

:: === DOWNLOAD BEPINEX ===
echo Downloading BepInEx...
curl -L -o bepinex.zip "%BEPINEX_URL%" || (
    echo Failed to download BepInEx.
    exit /b
)

:: === EXTRACT BEPINEX ===
echo Extracting BepInEx...
powershell -Command "Expand-Archive -Force 'bepinex.zip' '%TEMP%\bepinex'"

:: === COPY BEPINEX TO GAME ===
echo Installing BepInEx into Gorilla Tag...
xcopy /E /I /Y "%TEMP%\bepinex\*" "%GORILLA_TAG_PATH%"

:: === DOWNLOAD MOD MENU ===
echo Downloading M0NSTERMENU...
curl -L -o "%GORILLA_TAG_PATH%\BepInEx\plugins\M0NSTERMENU.dll" "%MODMENU_URL%" || (
    echo Failed to download mod menu.
    exit /b
)

:: === DONE ===
echo Installation complete!
pause
