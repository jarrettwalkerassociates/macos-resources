#!/bin/sh
# Enable location services and enforce ownership; path is no longer UUID dependent in Sierra
/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.notbackedup. LocationServicesEnabled -int 1
#/usr/sbin/chown -R _locationd:_locationd /var/db/locationd
# Update Time Zone preference to auto-adjust based upon location
/usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool YES
/usr/bin/defaults write /Library/Preferences/com.apple.locationmenu ShowSystemServices -bool YES