#!/bin/bash
#script to prompt user to load Xerox printer drivers.

dialogPath="/usr/local/bin/dialog"

#dialog command file
dialogCommandFile="/var/tmp/dialog.log"


# Printer command is lpstat -p | awk '{print $2}'

# Arlington printers are 
# Conference_G
#Highland_Ave
#West_Wing

#dialog command function
function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}

#consistent Dialog variables
dialogIcon="https://resources.jwainfrastructure.com/icns/qgis-styled.icns"
icon="SF=printer.fill,weight=medium"
dialogBannerImage="https://resources.jwainfrastructure.com/img/printer.jpg"

driverURL="https://www.support.xerox.com/en-us/product/versalink-c7020-c7025-c7030/downloads?platform=macOS14&category=&language=en&attributeId="

#primary Dialog message - fresh install
dialogTitle="Installing printer drivers"
dialogMessage="Before you can install the printers at the Arlington office, you'll need to manually install the printer drivers. Click 'Continue' to open the Xerox website and manually install the drivers.  \n\nAfter the installation completes, you should be able to install the printers in Self-Service."
dialogBannerTitle="Installing printer drivers"
dialogButtonText="Installing printer drivers"
dialogButton1Text="Continue"


sleep 0.1

"$dialogPath" \
--title "$dialogTitle" \
--message "$dialogMessage" \
--icon "$icon" \
--bannerimage "$dialogBannerImage" \
--bannerheight 85 \
--bannertitle "$dialogBannerTitle" \
--button1text "$dialogButton1Text" \
--button2text "Cancel" \
--iconalpha 1.0 \
--width 700 \
--messagefont "size=18" \
--height 300 \
--iconsize 120 \

    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

        if [ "$dialogResults" = 0 ]; then
            echo "Downloading latest QGIS LTR."
            open $driverURL
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
