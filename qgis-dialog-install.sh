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

#consistent Dialog variables
dialogIcon="https://resources.jwainfrastructure.com/icns/qgis-styled.icns"
dialogBannerImage="https://resources.jwainfrastructure.com/img/qgis-banner.png"

#primary Dialog message - fresh install
dialogTitleA="Installing QGIS"
dialogMessageA="QGIS is an important part of our analysis pipeline. However, we’re unable to automatically install and launch it because of restrictions in macOS. However, you can manually install QGIS.\n\nClick the “Install QGIS” button to open your browser and download the latest QGIS installer. After it downloads, run the installer.\n\nAfter QGIS is sucessfully installed, you’ll need to allow it to run. To do so, open Finder and click Applications, then find QGIS.\n\nHold down the Command (⌘) key and right-click (click with two fingers on a Mac trackpad), then click “Open”."
dialogBannerTitleA="Installing QGIS"
dialogWebImgA="https://resources.jwainfrastructure.com/img/qgis-launch-sonoma.png"
dialogButton1TextA="Install QGIS"
dialogWebImgA1=""

#secondary Dialog message - QGIS already installed.
dialogTitleB="QGIS already installed"
dialogMessageB="QGIS is already installed. However, you can still use this app to download the Latest version or the LTR (long-term release) version  \nFor consistency across the organization, we recommend using the **LTR version.**"
dialogBannerTitleB="QGIS already installed"
dialogButton1TextB="Install QGIS-LTR (recommended)"


app_name_1="QGIS-LTR.app"  # Replace with the actual application name you want to check
app_path_1="/Applications/$app_name_1"

app_name_2="QGIS.app"  # Replace with the actual application name you want to check
app_path_2="/Applications/$app_name_2"  # Typical location for applications

if [[ -d "$app_path_1" ] || [ -d "$app_path_2" ]]; then
    echo "QGIS is installed."

    "$dialogPath" \
    --title "$dialogTitleB" \
    --message "$dialogMessageB" \
    --icon "$dialogIcon" \
    --bannerimage "$dialogBannerImage" \
    --bannerheight 85 \
    --bannertitle "$dialogBannerTitle2" \
    --button1text "$dialogButton1TextB"
    --infotext "Advanced installation" \
    --infobuttonaction "https://qgis.org/download" \
    --button2 \
    --iconalpha 1.0 \
    --width 600 \
    --height 710 \
    --iconsize 120 \

    #Very important that this part comes immediately after the dialog command
    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "Downloading latest QGIS LTR."
        open https://qgis.org/downloads/macos/qgis-macos-ltr.dmg
    elif [ "$dialogResults" = 2 ]; then
        echo "Exit key was used."
    elif [ "$dialogResults" = 10 ]; then
        echo "Exit key was used."
    else
        echo "Dialog exited with an unexpected code."
        echo "Could be an error in the dialog command"
        echo "Could be the process killed somehow."
        echo "Exit with an error code."
        exit "$dialogResults"
    fi


elif ; then
    echo "$app_name_2 is installed."

else
    echo "$app_name is not installed."
fi