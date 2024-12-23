#!/bin/bash

set -x
# script for setting some of the CIS benchmarks during enrollment.

# setting log file
logfile="/var/tmp/prestage.log"
exec >$logfile 2>&1

# Sharing settings
# CIS 2.3.3.1 Disable CD/DVD Sharing
echo "Disabling CD and DVD sharing"
/bin/launchctl disable system/com.apple.ODSAgent
/bin/launchctl bootout system/com.apple.ODSAgent

# CIS 2.3.3.3 Disable Server Message Block Sharing
echo "Disabling SMB sharing"
/bin/launchctl disable system/com.apple.smbd

# CIS 2.3.3.4 Disable Printer Sharing
echo "Disabling printer sharing"
/usr/sbin/cupsctl --no-share-printers

# CIS 2.3.3.11 Disable Bluetooth Sharing
echo "Disabling Bluetooth sharing"
/usr/bin/defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool false

# CIS 2.3.3.8 Disable Internet Sharing
echo "confirm internet sharing status"
/usr/bin/defaults read /Library/Preferences/SystemConfiguration/com.apple.nat >nul 2>&1 | grep -c "Enabled = 1;"

# CIS 2.12.2 Disable Guest Access To Shared SMB Folders
/usr/sbin/sysadminctl -smbGuestAccess off

# CIS 4.3 Disable Network File System Service
echo "Disabling NFS"
/bin/launchctl disable system/com.apple.nfsd
/bin/rm /etc/exports

## macOS Settings
# CIS 5.1.2 Enable System Integrity Protection
echo "Confirming SIP status"
/usr/bin/csrutil status

# CIS 5.6 Disable root login
echo "Confirming ability to log in as root"
/usr/bin/dscl . -read /Users/root UserShell 2>&1 | /usr/bin/grep -c "/usr/bin/false"
/usr/bin/dscl . -create /Users/root UserShell /usr/bin/false
echo "Confirming ability to log in as root disabled"
/usr/bin/dscl . -read /Users/root UserShell 2>&1 | /usr/bin/grep -c "/usr/bin/false"

# CIS 5.1.1 Secure users home folders
# echo "Securing user home folders"
# IFS=$'\n'
# for userDirs in $( /usr/bin/find /System/Volumes/Data/Users -mindepth 1 -maxdepth 1 -type d ! \( -perm 700 -o -perm 711 \) | /usr/bin/grep -v "Shared" | /usr/bin/grep -v "Guest" ); do
#   /bin/chmod og-rwx "$userDirs"
# done
# unset IFS

# CIS 2.11.1 Remove password hint from user accounts 
echo "Removing password hint from user accounts"
for u in $(/usr/bin/dscl . -list /Users UniqueID | /usr/bin/awk '$2 > 500 {print $1}'); do
  /usr/bin/dscl . -delete /Users/$u hint
done

# CIS 3.3 Configure install.log Retention to 365 days
echo "Configuring install log length"
/usr/bin/sed -i '' "s/\* file \/var\/log\/install.log.*/\* file \/var\/log\/install.log format='\$\(\(Time\)\(JZ\)\) \$Host \$\(Sender\)\[\$\(PID\\)\]: \$Message' rotate=utc compress file_max=50M size_only ttl=365/g" /etc/asl/com.apple.install

# CIS 2.9.3 Disable Wake For Network Access
echo "Disabling Wake for Network Access"
/usr/bin/pmset -a womp 0

exit

echo 0

