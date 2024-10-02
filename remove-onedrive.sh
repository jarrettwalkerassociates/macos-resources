#!/bin/sh

# Check if OneDrive is running
if ( pgrep -x "OneDrive" >/dev/null ); then
	echo "OneDrive is Running"
	/usr/bin/killall OneDrive
else
	echo "OneDrive is Not Running"
fi

# Uninstall OneDrive.app
rm -rf /Applications/OneDrive.app

exit 0