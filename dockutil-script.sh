#!/bin/bash

#dockutil settings courtesy of John de Vries on macAdmins Slack

currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
dockPrefs="/Users/$currentUser/Library/Preferences/com.apple.dock.plist"
uid=$(id -u "$currentUser")

runAsUser() {  
	if [ "$currentUser" != "loginwindow" ]; then
		launchctl asuser "$uid" sudo -u "$currentUser" "$@"
	else
		echo "no user logged in"
	fi
}

addToDock() {  
		runAsUser /usr/local/bin/dockutil --add "$@" --allhomes /Users/$currentUser > /dev/null 2>&1 || true
}

addToDockEnd() {  
		runAsUser /usr/local/bin/dockutil --add "$@" --allhomes --position end /Users/$currentUser > /dev/null 2>&1 || true
}

removeFromDock() {  
		runAsUser /usr/local/bin/dockutil --remove "$@" --allhomes /Users/$currentUser > /dev/null 2>&1 || true
}


addToDock "/Applications/Microsoft Word.app"
addToDock "/Applications/Microsoft Excel.app"
addToDock "/Applications/Microsoft PowerPoint.app"
addToDock "/Applications/Self-Service.app"
addToDock "/Applications/1Password.app"
addToDockEnd "/Applications/Privileges.app"

removeFromDock "/System/Applications/Music.app"
removeFromDock "/System/Applications/News.app"
removeFromDock "/System/Applications/TV.app"
removeFromDock "/System/Applications/Messages.app"
removeFromDock "/System/Applications/FaceTime.app"
removeFromDock "/System/Applications/FaceTime.app"
removeFromDock "/System/Applications/Photos.app"
removeFromDock "/Applications/Photos.app"
removeFromDock "/System/Applications/Freeform.app"

exit