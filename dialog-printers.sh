#!/bin/bash
#script to prompt user to load Xerox printer drivers.

dialogPath="/usr/local/bin/dialog"

#dialog command file
dialogCommandFile="/var/tmp/dialog.log"


# Printer command is lpstat -p | awk '{print $2}'

# Arlington printers are Conference_G
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
icon="SF=printer.fill"
dialogBannerImage="https://resources.jwainfrastructure.com/img/engin-akyurt-CGnoRQZGWmw-unsplash.jpg"

driverURL="https://www.support.xerox.com/en-us/product/versalink-c7020-c7025-c7030/downloads?platform=macOS14&category=&language=en&attributeId="

#primary Dialog message - fresh install
dialogTitle="Installing printer drivers"
dialogMessage=""
dialogBannerTitleA="Installing printer drivers"
dialogButton1TextA="Installing printer drivers"


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