@ECHO OFF 
::Try to copy from mods folder, if it exists. If not, test if the file is located inside mods folder and attempt to copy again 
IF EXIST ..\mods\mod-list.json ( 
	IF EXIST ..\mods\mod-settings.dat ( 
		COPY /v "..\mods\mod-list.json" "mod-list.json" 
		COPY /v "..\mods\mod-settings.dat" "mod-settings.dat" 
		ECHO mod configuration in mods folder successfully changed! 
		PAUSE  
		EXIT /b 0 
	) 
) 
IF EXIST ..\mod-list.json ( 
	IF EXIST ..\mod-settings.dat ( 
		COPY /v "..\mod-list.json" "mod-list.json" 
		COPY /v "..\mod-settings.dat" "mod-settings.dat" 
		ECHO mod configuration in mods folder successfully changed! 
		PAUSE 
		EXIT /b 0 
	) 
) 
::this section will only execute if mods folder is not in the same directory and mods if it also not inside the mods folder 
ECHO mod list or mod settings not found. Please make sure the mod configuration is inside the Factorio directory or inside Factorio/mods 
PAUSE 
EXIT /b 1 
