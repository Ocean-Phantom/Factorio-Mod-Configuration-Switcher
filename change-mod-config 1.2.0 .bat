@ECHO OFF
::Make sure the files exist
IF EXIST mod-list.json ( 
	ECHO mod list detected
) ELSE ( 
	ECHO ERROR: mod-list.json not found or does not exist. Please ensure mod-list.json is in the same directory as this file and try again.
	PAUSE 
	EXIT /b 1 
)
IF EXIST mod-settings.dat ( 
	ECHO mod-settings.dat detected
) ELSE ( 
	ECHO ERROR: mod-settings.dat not found or does not exist. Please ensure mod-settings.dat is in the same directory as this file and try again.
	PAUSE 
	EXIT /b 1 
)
::Try to insert copies into a mods folder, if it exists. If not, test if the file is located inside mods folder and insert there
IF EXIST ..\mods (
	COPY /v "mod-list.json" "..\mods\mod-list.json"
	COPY /v "mod-settings.dat" "..\mods\mod-settings.dat"
	ECHO mod configuration in mods folder successfully changed!
	PAUSE
	EXIT /b 0 
) 
IF EXIST ..\mod-list.json ( 
	IF EXIST ..\mod-settings.dat ( 
		COPY /v "mod-list.json" "..\mod-list.json"
		COPY /v "mod-settings.dat" "..\mod-settings.dat"
		ECHO mod configuration in mods folder successfully changed! 
		PAUSE
		EXIT /b 0 
	)
)
::this section will only execute if mods folder is not in the same directory and mods if it also not inside the mods folder
ECHO mods folder not found. Please make sure the mod configuration is inside the Factorio directory or inside Factorio/mods
PAUSE
EXIT /b 1 
