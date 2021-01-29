@ECHO OFF
PUSHD %~dp0

:: Check for Admin rights
:l_PermissionCheck
echo This script must be run as an Administrator, checking...

net session >nul 2>&1
if %ERRORLEVEL% == 0 (
	echo You are an Administrator!
	echo.
	) else (
	echo You are not an Administrator.
	echo.
	echo Press any key to exit.
	pause > nul
	exit
	)

:l_ResourceInstall
:: Install resources
ECHO Copying resources...
ECHO.
IF EXIST "C:\Windows\CustomCommands" RMDIR /Q /S "C:\Windows\CustomCommands"
IF EXIST "C:\Windows\CustomIcons" RMDIR /Q /S "C:\Windows\CustomIcons"

ROBOCOPY "Resources\CustomCommands" "C:\Windows\CustomCommands" /E /COPYALL > install_log.txt
ROBOCOPY "Resources\CustomIcons" "C:\Windows\CustomIcons" /E /COPYALL >> install_log.txt

:l_RegistryInstall
:: Merge registry information
ECHO Merging registry information...
ECHO.
REGEDIT /S "Resources\CodingShell.reg"

ECHO Done! 
ECHO.
ECHO Press any button to close this window.
PAUSE > nul