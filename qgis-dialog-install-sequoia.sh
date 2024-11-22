#!/bin/bash
#script to prompt user to install QGIS via Dialog, if already installed, then use it as an opportunity to check version

# #macOS version check for Gatekeeper bypass
# #TODO get images from Sequoia
# macOSVersion=$(sw_vers -productVersion)
# sequoia="15.0.0"


# if  [[ "${macOSVersion}" == "${sequoia}"* ]]; then
#    echo "Mac is running Sequoia - use different Gatekeeper instructions"
#    exit 0
# else
#     echo "Mac is not on an OK version."
#     exit 1
# fi

#set dialog path
dialogPath="/usr/local/bin/dialog"

#dialog command file
dialogCommandFile="/var/tmp/dialog.log"

#dialog command function
function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}

#consistent Dialog variables
dialogIcon="https://resources.jwainfrastructure.com/icns/qgis-styled.icns"
dialogBannerImage="https://resources.jwainfrastructure.com/img/qgis-banner.png"

#primary Dialog message - fresh install
dialogTitleA="Installing QGIS"
dialogMessageA="QGIS is an important part of our analysis pipeline. However, we’re unable to automatically install and launch it because of restrictions in macOS. However, you can manually install QGIS.  \n\nClick the “Install QGIS” button to open your browser and download the latest QGIS installer. After it downloads, run the installer.  \n\n### After the install  \n\n1. Go to System Settings > Privacy & Security\n2. Scroll down to find QGIS\n3. Click 'Open Anyway'\n4. Click 'Open' in the confirmation dialog"
# dialogMessageA="QGIS is an important part of our analysis pipeline. However, we’re unable to automatically install and launch it because of restrictions in macOS. However, you can manually install QGIS.\n\nClick the “Install QGIS” button to open your browser and download the latest QGIS installer. After it downloads, run the installer.\n\nAfter QGIS is sucessfully installed, you’ll need to allow it to run. To do so, open Finder and click Applications, then find QGIS.\n\nHold down the Command (⌘) key and right-click (click with two fingers on a Mac trackpad), then click “Open”.<br><br>![Gatekeeper](https://resources.jwainfrastructure.com/img/qgis-launch-sonoma.png)"
dialogBannerTitleA="Installing QGIS"
dialogButton1TextA="Install QGIS"

#secondary Dialog message - QGIS already installed.
dialogTitleB="QGIS already installed"
dialogMessageB="QGIS is already installed. However, you can still use this app to download it again or update it.  \n\nFor consistency across the organization, we recommend using the **LTR version.**  \n\nIf you want to Download the “Latest” release, click on **Advanced installation**.  \n### After the install  \n\n1. Go to System Settings > Privacy & Security\n2. Scroll down to find QGIS\n3. Click 'Open Anyway'\n4. Click 'Open' in the confirmation dialog"
dialogBannerTitleB="QGIS already installed"
dialogButton1TextB="Download QGIS-LTR"


app_name_1="QGIS-LTR.app"  # Replace with the actual application name you want to check
app_path_1="/Applications/$app_name_1"

app_name_2="QGIS.app"  # Replace with the actual application name you want to check
app_path_2="/Applications/$app_name_2"  # Typical location for applications


if [ -d "$app_path_1" ]; then
    echo "QGIS_LTR is installed."

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
    --iconsize 120 \

    #Very important that this part comes immediately after the dialog command
    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "Downloading latest QGIS LTR."
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg
    elif [ "$dialogResults" = 2 ]; then
        echo "User cancelled."
    elif [ "$dialogResults" = 10 ]; then
        echo "Exit key was used."
    else
        echo "Dialog exited with an unexpected code."
        echo "Could be an error in the dialog command"
        echo "Could be the process killed somehow."
        echo "Exit with an error code."
        exit "$dialogResults"
    fi


elif [ -d "$app_path_2" ]; then
    echo "QGIS Latest is installed."

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
    --iconsize 120 \

    dialogResults=$?
    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "Downloading latest QGIS LTR."
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg
    elif [ "$dialogResults" = 2 ]; then
        echo "User cancelled."
    elif [ "$dialogResults" = 10 ]; then
        echo "Exit key was used."
    else
        echo "Dialog exited with an unexpected code."
        echo "Could be an error in the dialog command"
        echo "Could be the process killed somehow."
        echo "Exit with an error code."
        exit "$dialogResults"
    fi

else
    echo "QGIS is not installed."
    
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
    --iconsize 120 \

    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "Downloading latest QGIS LTR."
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg
        
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
        --iconsize 120 \

        dialogResults=$?

    elif [ "$dialogResults" = 2 ]; then
        echo "User cancelled."
    elif [ "$dialogResults" = 10 ]; then
        echo "Exit key was used."
    else
        echo "Dialog exited with an unexpected code."
        echo "Could be an error in the dialog command"
        echo "Could be the process killed somehow."
        echo "Exit with an error code."
        exit "$dialogResults"
    fi

fi