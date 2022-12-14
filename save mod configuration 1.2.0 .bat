@ECHO OFF
ECHO Path to batch file should match this format: "<Drive Letter>:\<username>\AppData\Roaming\Factorio" or "<Drive Letter>:\<username>\AppData\Roaming\Factorio\mods"
ECHO The current path is:
ECHO %cd%
PAUSE

::Make sure all relevant files exist
SET /a MODFILES=0
IF EXIST mods\mod-list.json ( 
	ECHO "mod list detected"
	SET /a MODFILES=%MODFILES%+1
) ELSE (
	IF EXIST mod-list.json ( 
		ECHO "mod list detected"
		SET /a MODFILES=%MODFILES%-1
	) ELSE (
		ECHO "error: mod list not found or does not exist. Please place this file in your Factorio Directory (AppData/Roaming/Factorio) or inside Factorio/mods and try again."
		PAUSE 
		EXIT /b 1
	)
)
IF EXIST mods\mod-settings.dat ( 
	ECHO "mod settings detected"
	SET /a MODFILES=%MODFILES%+1
) ELSE (
	IF EXIST mod-settings.dat ( 
		ECHO "mod settings detected"
		SET /a MODFILES=%MODFILES%-1
	) ELSE ( 
		ECHO "error: mod settings not found or does not exist. Please place this file in your Factorio Directory (AppData/Roaming/Factorio) or inside Factorio/mods and try again."
		PAUSE 
		EXIT /b 1
	)
)

::Get current date, time formatted
for /F "tokens=1,2,3,4,5 delims=_" %%i in ('PowerShell -Command "& {Get-Date -format "MM_dd_yyyy_HH_mm"}"') do (
    SET MONTH=%%i
    SET DAY=%%j
    SET YEAR=%%k
	SET HOUR=%%l
	SET MINUTE=%%m
)
ECHO Current Date and Time: %MONTH% %DAY% %YEAR% %HOUR% %MINUTE%

::make unique folder name for config and copy mod settings in
SET "foldername=mod-config-%YEAR%-%MONTH%-%DAY%--%HOUR%-%MINUTE%"
MKDIR %foldername%
IF EXIST %foldername% (
	ECHO "Successfully made new folder %foldername%"
) ELSE (
	ECHO "Failed to make folder"
	PAUSE
	EXIT /b 1
)

IF %MODFILES% EQU 2 ( 
	GOTO :OUTSIDE
)
IF %MODFILES% EQU -2 (
	GOTO :INSIDE
)
:: will only execute if mod-list and mod-settings are not in the same directory
ECHO "error: mod-list and mod-settings must be in the same directory as each other"
PAUSE
EXIT /b 2

:OUTSIDE
COPY /v "mods\mod-list.json" "%foldername%"
COPY /v "mods\mod-settings.dat" "%foldername%"
IF EXIST %foldername%\mod-list.json (
	IF EXIST %foldername%\mod-settings.dat (
		ECHO "Successfully copied mod configuration"
		GOTO :CREATE
	) ELSE (
		ECHO "Something went wrong"
		EXIT /b 1
	)
) ELSE (
	ECHO "Something went wrong"
	EXIT /b 1
)

:INSIDE
COPY /v "mod-list.json" "%foldername%"
COPY /v "mod-settings.dat" "%foldername%"
IF EXIST %foldername%\mod-list.json (
	IF EXIST %foldername%\mod-settings.dat (
		ECHO "Successfully copied mod configuration"
		GOTO :CREATE
	) ELSE (
		ECHO "Something went wrong"
		EXIT /b 1
	)
) ELSE (
	ECHO "Something went wrong"
	EXIT /b 1
)


:CREATE
CD %foldername%

::make new batch file that just overwrites the current config in \mods with whatever is in the same folder as the batch file
ECHO @ECHO OFF>"change-mod-config 1.2.0 .bat"
ECHO ::Make sure the files exist>>"change-mod-config 1.2.0 .bat"
ECHO IF EXIST mod-list.json ( >>"change-mod-config 1.2.0 .bat"
ECHO 	ECHO mod list detected>>"change-mod-config 1.2.0 .bat"
ECHO ) ELSE ( >>"change-mod-config 1.2.0 .bat"
ECHO 	ECHO ERROR: mod-list.json not found or does not exist. Please ensure mod-list.json is in the same directory as this file and try again.>>"change-mod-config 1.2.0 .bat"
ECHO 	PAUSE >>"change-mod-config 1.2.0 .bat"
ECHO 	EXIT /b 1 >>"change-mod-config 1.2.0 .bat"
ECHO )>>"change-mod-config 1.2.0 .bat"
ECHO IF EXIST mod-settings.dat ( >>"change-mod-config 1.2.0 .bat"
ECHO 	ECHO mod-settings.dat detected>>"change-mod-config 1.2.0 .bat"
ECHO ) ELSE ( >>"change-mod-config 1.2.0 .bat"
ECHO 	ECHO ERROR: mod-settings.dat not found or does not exist. Please ensure mod-settings.dat is in the same directory as this file and try again.>>"change-mod-config 1.2.0 .bat"
ECHO 	PAUSE >>"change-mod-config 1.2.0 .bat"
ECHO 	EXIT /b 1 >>"change-mod-config 1.2.0 .bat"
ECHO )>>"change-mod-config 1.2.0 .bat"
ECHO ::Try to insert copies into a mods folder, if it exists. If not, test if the file is located inside mods folder and insert there>>"change-mod-config 1.2.0 .bat"
ECHO IF EXIST ..\mods (>>"change-mod-config 1.2.0 .bat"
ECHO 	COPY /v "mod-list.json" "..\mods\mod-list.json">>"change-mod-config 1.2.0 .bat"
ECHO 	COPY /v "mod-settings.dat" "..\mods\mod-settings.dat">>"change-mod-config 1.2.0 .bat"
ECHO 	ECHO mod configuration in mods folder successfully changed!>>"change-mod-config 1.2.0 .bat"
ECHO 	PAUSE>>"change-mod-config 1.2.0 .bat"
ECHO 	EXIT /b 0 >>"change-mod-config 1.2.0 .bat"
ECHO ) >>"change-mod-config 1.2.0 .bat"
ECHO IF EXIST ..\mod-list.json ( >>"change-mod-config 1.2.0 .bat"
ECHO 	IF EXIST ..\mod-settings.dat ( >>"change-mod-config 1.2.0 .bat"
ECHO 		COPY /v "mod-list.json" "..\mod-list.json">>"change-mod-config 1.2.0 .bat"
ECHO 		COPY /v "mod-settings.dat" "..\mod-settings.dat">>"change-mod-config 1.2.0 .bat"
ECHO 		ECHO mod configuration in mods folder successfully changed! >>"change-mod-config 1.2.0 .bat"
ECHO 		PAUSE>>"change-mod-config 1.2.0 .bat"
ECHO 		EXIT /b 0 >>"change-mod-config 1.2.0 .bat"
ECHO 	)>>"change-mod-config 1.2.0 .bat"
ECHO )>>"change-mod-config 1.2.0 .bat"
ECHO ::this section will only execute if mods folder is not in the same directory and mods if it also not inside the mods folder>>"change-mod-config 1.2.0 .bat"
ECHO ECHO mods folder not found. Please make sure the mod configuration is inside the Factorio directory or inside Factorio/mods>>"change-mod-config 1.2.0 .bat"
ECHO PAUSE>>"change-mod-config 1.2.0 .bat"
ECHO EXIT /b 1 >>"change-mod-config 1.2.0 .bat"

::make new batch file that updates the configs in the folder
ECHO @ECHO OFF >"update-mod-config 1.2.0 .bat"
ECHO ::Try to copy from mods folder, if it exists. If not, test if the file is located inside mods folder and attempt to copy again >>"update-mod-config 1.2.0 .bat"
ECHO IF EXIST ..\mods\mod-list.json ( >>"update-mod-config 1.2.0 .bat"
ECHO 	IF EXIST ..\mods\mod-settings.dat ( >>"update-mod-config 1.2.0 .bat"
ECHO 		COPY /v "..\mods\mod-list.json" "mod-list.json" >>"update-mod-config 1.2.0 .bat"
ECHO 		COPY /v "..\mods\mod-settings.dat" "mod-settings.dat" >>"update-mod-config 1.2.0 .bat"
ECHO 		ECHO mod configuration in mods folder successfully changed! >>"update-mod-config 1.2.0 .bat"
ECHO 		PAUSE  >>"update-mod-config 1.2.0 .bat"
ECHO 		EXIT /b 0 >>"update-mod-config 1.2.0 .bat"
ECHO 	) >>"update-mod-config 1.2.0 .bat"
ECHO ) >>"update-mod-config 1.2.0 .bat"
ECHO IF EXIST ..\mod-list.json ( >>"update-mod-config 1.2.0 .bat"
ECHO 	IF EXIST ..\mod-settings.dat ( >>"update-mod-config 1.2.0 .bat"
ECHO 		COPY /v "..\mod-list.json" "mod-list.json" >>"update-mod-config 1.2.0 .bat"
ECHO 		COPY /v "..\mod-settings.dat" "mod-settings.dat" >>"update-mod-config 1.2.0 .bat"
ECHO 		ECHO mod configuration in mods folder successfully changed! >>"update-mod-config 1.2.0 .bat"
ECHO 		PAUSE >>"update-mod-config 1.2.0 .bat"
ECHO 		EXIT /b 0 >>"update-mod-config 1.2.0 .bat"
ECHO 	) >>"update-mod-config 1.2.0 .bat"
ECHO ) >>"update-mod-config 1.2.0 .bat"
ECHO ::this section will only execute if mods folder is not in the same directory and mods if it also not inside the mods folder >>"update-mod-config 1.2.0 .bat"
ECHO ECHO mod list or mod settings not found. Please make sure the mod configuration is inside the Factorio directory or inside Factorio/mods >>"update-mod-config 1.2.0 .bat"
ECHO PAUSE >>"update-mod-config 1.2.0 .bat"
ECHO EXIT /b 1 >>"update-mod-config 1.2.0 .bat"

ECHO Press any key to open the folder.
PAUSE

START "" "%cd%"
EXIT /b 0