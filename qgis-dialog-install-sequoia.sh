#!/bin/bash
#script to prompt user to install QGIS via Dialog, if already installed, then use it as an opportunity to check version

dialogPath="/usr/local/bin/dialog"
dialogCommandFile="/var/tmp/dialog.log"

function dialog_command(){
    /bin/echo "$@" >> "$dialogCommandFile" 2>/dev/null
    log_message "$@" 2>/dev/null
    sleep .1
}

dialogIcon="https://resources.jwainfrastructure.com/icns/qgis-styled.icns"
dialogBannerImage="https://resources.jwainfrastructure.com/img/qgis-banner.png"

dialogTitleA="Installing QGIS"
dialogMessageA="QGIS is an important part of our analysis pipeline. However, we're unable to automatically install and launch it because of restrictions in macOS. However, you can manually install QGIS.  \n\nClick the Install QGIS button to open your browser and download the latest QGIS installer. After it downloads, run the installer.  \n\n### After the install  \n\n1. Go to System Settings > Privacy & Security\n2. Scroll down to find QGIS\n3. Click 'Open Anyway'\n4. Click 'Open' in the confirmation dialog"
dialogBannerTitleA="Installing QGIS"
dialogButton1TextA="Install QGIS"

dialogTitleB="QGIS already installed"
dialogMessageB="QGIS is already installed. However, you can still use this app to download it again or update it.  \n\nFor consistency across the organization, we recommend using the **LTR version.**  \n\nIf you want to Download the Latest release, click on **Advanced installation**.  \n### After the install  \n\n1. Go to System Settings > Privacy & Security\n2. Scroll down to find QGIS\n3. Click 'Open Anyway'\n4. Click 'Open' in the confirmation dialog"
dialogBannerTitleB="QGIS already installed"
dialogButton1TextB="Download QGIS-LTR"

app_name_1="QGIS-LTR.app"
app_path_1="/Applications/$app_name_1"

app_name_2="QGIS.app"
app_path_2="/Applications/$app_name_2"

if [ -d "$app_path_1" ] 2>/dev/null; then
    echo "QGIS_LTR is installed." 2>/dev/null

    sleep 0.1

    "$dialogPath" \
    --title "$dialogTitleB" \
    --message "$dialogMessageB" \
    --icon "$dialogIcon" \
    --bannerimage "$dialogBannerImage" \
    --bannerheight 85 \
    --bannertitle "$dialogBannerTitle2" \
    --button1text "$dialogButton1TextB" \
    --infobuttontext "Advanced installation" \
    --infobuttonaction "https://qgis.org/download" \
    --button2text "Cancel" \
    --iconalpha 1.0 \
    --width 700 \
    --messagefont "size=18" \
    --height 505 \
    --iconsize 120 2>/dev/null

    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults" 2>/dev/null

    if [ "$dialogResults" = 0 ] 2>/dev/null; then
        echo "Downloading latest QGIS LTR." 2>/dev/null
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg 2>/dev/null
    elif [ "$dialogResults" = 2 ] 2>/dev/null; then
        echo "User cancelled." 2>/dev/null
    elif [ "$dialogResults" = 10 ] 2>/dev/null; then
        echo "Exit key was used." 2>/dev/null
    else
        echo "Dialog exited with an unexpected code." 2>/dev/null
        echo "Could be an error in the dialog command" 2>/dev/null
        echo "Could be the process killed somehow." 2>/dev/null
        echo "Exit with an error code." 2>/dev/null
        exit "$dialogResults" 2>/dev/null
    fi

elif [ -d "$app_path_2" ] 2>/dev/null; then
    echo "QGIS Latest is installed." 2>/dev/null

    sleep 0.1
    
    "$dialogPath" \
    --title "$dialogTitleB" \
    --message "$dialogMessageB" \
    --icon "$dialogIcon" \
    --bannerimage "$dialogBannerImage" \
    --bannerheight 85 \
    --bannertitle "$dialogBannerTitle2" \
    --button1text "$dialogButton1TextB" \
    --infobuttontext "Advanced installation" \
    --infobuttonaction "https://qgis.org/download" \
    --button2text "Cancel" \
    --iconalpha 1.0 \
    --width 700 \
    --messagefont "size=18" \
    --height 505 \
    --iconsize 120 2>/dev/null

    dialogResults=$?
    echo "Dialog exited with the following code: $dialogResults" 2>/dev/null

    if [ "$dialogResults" = 0 ] 2>/dev/null; then
        echo "Downloading latest QGIS LTR." 2>/dev/null
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg 2>/dev/null
    elif [ "$dialogResults" = 2 ] 2>/dev/null; then
        echo "User cancelled." 2>/dev/null
    elif [ "$dialogResults" = 10 ] 2>/dev/null; then
        echo "Exit key was used." 2>/dev/null
    else
        echo "Dialog exited with an unexpected code." 2>/dev/null
        echo "Could be an error in the dialog command" 2>/dev/null
        echo "Could be the process killed somehow." 2>/dev/null
        echo "Exit with an error code." 2>/dev/null
        exit "$dialogResults" 2>/dev/null
    fi

else
    echo "QGIS is not installed." 2>/dev/null
    
    "$dialogPath" \
    --title "$dialogTitleA" \
    --message "$dialogMessageA" \
    --icon "$dialogIcon" \
    --bannerimage "$dialogBannerImage" \
    --bannerheight 85 \
    --bannertitle "$dialogBannerTitleA" \
    --button1text "$dialogButton1TextA" \
    --infobuttontext "More info" \
    --infobuttonaction "https://qgis.org/download" \
    --button2text "Cancel" \
    --iconalpha 1.0 \
    --messagefont "size=18" \
    --width 700 \
    --height 500 \
    --iconsize 120 2>/dev/null

    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults" 2>/dev/null

    if [ "$dialogResults" = 0 ] 2>/dev/null; then
        echo "Downloading latest QGIS LTR." 2>/dev/null
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg 2>/dev/null
        
        "$dialogPath" \
        --title "$dialogTitleA" \
        --message "\n\Remember to check System Settings > Privacy & Security after installation to allow QGIS to run. \n\n![Gatekeeper](https://resources.jwainfrastructure.com/img/sequoia-gatekeeper.png)" \
        --icon "$dialogIcon" \
        --bannerimage "$dialogBannerImage" \
        --bannerheight 85 \
        --bannertitle "$dialogBannerTitleA" \
        --button1text "Close and continue" \
        --infobuttontext "More info" \
        --infobuttonaction "https://qgis.org/download" \
        --iconalpha 1.0 \
        --messagefont "size=15" \
        --width 700 \
        --height 600 \
        --iconsize 120 2>/dev/null

        dialogResults=$?

    elif [ "$dialogResults" = 2 ] 2>/dev/null; then
        echo "User cancelled." 2>/dev/null
    elif [ "$dialogResults" = 10 ] 2>/dev/null; then
        echo "Exit key was used." 2>/dev/null
    else
        echo "Dialog exited with an unexpected code." 2>/dev/null
        echo "Could be an error in the dialog command" 2>/dev/null
        echo "Could be the process killed somehow." 2>/dev/null
        echo "Exit with an error code." 2>/dev/null
        exit "$dialogResults" 2>/dev/null
    fi
fi