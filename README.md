# Factorio Mod Configuration Switcher
 
## What is this / What does this do?

This is a tool that allows you to save and switch the mods you use quickly, without having to enter the game.

## Instructions

1. Copy or move **save mod configuration.bat** into your Factorio appdata directory. Default for Windows is C:/Users/NAMEHERE/AppData/Roaming/Factorio 
![](/images/Folder-Before.png)

2. Run factorio, select whatever mods you want for a config you wish to save. Change mod settings if necessary. 

3. Run **save mod configuration.bat** 

![](/images/Running-Batch-File.png)

4. It will create and open a new folder with a copy of your mod-list and mod-settings. It will also create another .bat file in that folder titled **change mod configuration.bat**
![](/images/Folder-After.png)

5. Running the second .bat file will overwrite the files of the same name in the mod folder 
![](/images/Created-Folder.png)


### Recommendations:
 
 - I personally make a folder filled with shortcuts for each .bat file that is either in the same directory as your factorio shortcut, or contains it.
 - Rename the shortcuts to something recognizable
 - Make one configuration of Factorio without mods (e.g. base only) to quickly remove any mods 
![](/images/Sample-Shortcuts.png)


### Why use this over just syncing mods with saves  oradding modpack paths to factorio's command line parameters?

First, if you don't know what those are or how to use them:

Sync mods with save: https://forums.factorio.com/viewtopic.php?p=419933#p419933. - A simple button available in the top right of the UI. It's also the middle option that pops up when you try to load a save with mods that are different to your currently enabled ones. This does however, require you to open up the game to do this. 


Command Line Parameters: https://wiki.factorio.com/Command_line_parameters - You can add a specific path to a mod/set of mods to your Factorio game. Such as "C:\PATHTOFACTORIO\factorio.exe" --mod-directory %APPDATA%\Factorio\mods-QOL

With this second method, it will naturally take up more space in your computer's storage if you use the same mods multiple times. Generally not an issue with the 
large storage sizes of today, but still a potential concern. And of course, if that mod has an update, the updates are not synced between each different folder. 

While this *can* be desired behavior if you need a specific version of a mod/s for compatibility reasons, it can also become tedious to download the same mod many times or copy the folder manually.


With the batch file provided here, much like the in-game mod syncing, all versions of the mods will be synced.

TLDR:

This can be used whenever the version numbers do not matter. If the version of the mods does matter, use the command line method. Sync mods with save is always a convenient option, provided you don't mind waiting for the game to load :)

## Potential issues:

 - There is no way to 'update' a configuration with this script. If you wish to change settings, add or remove mods, etc., you will have to save the new config. Either run the script again (which creates a new config), or copy & replace **mod-list.json** and **mod-settings.dat** from your mods folder into the appropriate configuration folder.
