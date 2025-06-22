@echo off
setlocal


set /p USERINPUT=Do you wish to install? (y/n): 
if /i "%USERINPUT%"=="y" goto install
if /i "%USERINPUT%"=="n" goto end
echo Invalid input.
goto end


set "GORILLA_TAG_PATH=C:\Program Files (x86)\Steam\steamapps\common\Gorilla Tag"
set "BEPINEX_URL=https://github.com/BepInEx/BepInEx/releases/download/v5.4.21/BepInEx_x64_5.4.21.0.zip"
set "MODMENU_URL=https://github.com/LILmonster9285/M0NSTERMENU/releases/download/v1.0.0/M0NSTERMENU.dll"

echo.
echo Installing M0NSTERMENU and BepInEx...
cd /d "%~dp0"


echo Downloading BepInEx...
curl -L -o bepinex.zip "%BEPINEX_URL%"
if errorlevel 1 (
    echo Failed to download BepInEx.
    goto end
)


echo Extracting BepInEx...
powershell -Command "Expand-Archive -Force 'bepinex.zip' '%TEMP%\bepinex'"


echo Installing BepInEx into Gorilla Tag...
xcopy /E /I /Y "%TEMP%\bepinex\*" "%GORILLA_TAG_PATH%\"

echo Downloading M0NSTERMENU...
curl -L -o "%GORILLA_TAG_PATH%\BepInEx\plugins\M0NSTERMENU.dll" "%MODMENU_URL%"
if errorlevel 1 (
    echo Failed to download mod menu.
    goto end
)

echo.
echo Installation complete!
pause
goto end

:end
echo Exiting...
endlocal
exit /b
