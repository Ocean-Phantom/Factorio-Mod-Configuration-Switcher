@ECHO OFF
ECHO Path to batch file should match this format: "<Drive Letter>:\<username>\AppData\Roaming\Factorio
ECHO Current path:
ECHO %cd%
PAUSE

::make sure all relevant files exist
IF EXIST mods ( 
	ECHO "mods folder detected"
) ELSE ( 
	ECHO "error: mods folder not found or does not exist. Please place this file in your Factorio Directory (AppData/Roaming/Factorio) and try again."
	PAUSE 
	goto :EOF
)
IF EXIST mods/mod-list.json ( 
	ECHO "mod list detected"
) ELSE ( 
	ECHO "error: mod list file not found or does not exist. Please place this file in your Factorio Directory (AppData/Roaming/Factorio) and try again."
	PAUSE 
	goto :EOF
)
IF EXIST mods/mod-settings.dat ( 
	ECHO "mod settings detected"
) ELSE ( 
	ECHO "error: mods folder not found or does not exist. Please place this file in your Factorio Directory (AppData/Roaming/Factorio) and try again."
	PAUSE 
	goto :EOF
)
::Get current date, time formatted
for /F "tokens=1,2,3,4,5 delims=_" %%i in ('PowerShell -Command "& {Get-Date -format "MM_dd_yyyy_hh_mm"}"') do (
    SET MONTH=%%i
    SET DAY=%%j
    SET YEAR=%%k
	SET HOUR=%%l
	SET MINUTE=%%m
)
ECHO %MONTH% %DAY% %YEAR% %HOUR% %MINUTE%

::make unique folder name for config and copy mod settings in
SET "foldername=mod-config-%YEAR%-%MONTH%-%DAY%--%HOUR%-%MINUTE%"
MKDIR %foldername%
IF EXIST %foldername% (
	ECHO "Successfully made new folder"
) ELSE (
	ECHO "Failed to make folder"
	PAUSE
	goto :EOF
)
COPY /v "mods\mod-list.json" "%foldername%"
COPY /v "mods\mod-settings.dat" "%foldername%"
PAUSE
IF EXIST %foldername%/mod-list.json (
	IF EXIST %foldername%/mod-settings.dat (
		ECHO "Successfully copied mod configuration"
	) ELSE (
		ECHO "Something went wrong"
	)
) ELSE (
	ECHO "Something went wrong"
	GOTO :EOF
)

cd %foldername%

::make new batch file that just overwrites config with whatever is in the folder
ECHO @ECHO OFF>change-mod-config.bat
ECHO COPY /v "mod-list.json" "..\mods\mod-list.json">>change-mod-config.bat
ECHO COPY /v "mod-settings.dat" "..\mods\mod-settings.dat">>change-mod-config.bat
ECHO ECHO mod configuration overwritten!>>change-mod-config.bat
ECHO PAUSE>>change-mod-config.bat


start "" "%cd%"
EXIT /b