#!/bin/bash
#script to redirect to support portal

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
icon="SF=wrench.and.screwdriver.fill,weight=medium"
dialogBannerImage="https://resources.jwainfrastructure.com/img/pdx-monochrome.png"

supportURL="https://support.jarrettwalker.com/"

#primary Dialog message - fresh install
dialogMessage="Need help from IT? Visit the [JWA IT support portal](https://support.jarrettwalker.com/) to request assistance.  \n\nYou'll need to sign in with your Google Workspace account to access support resources."
dialogBannerTitle="Getting help from IT"
dialogButton1Text="Go to support portal"


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
--buttonstyle stack \
--iconalpha 1.0 \
--messagefont "size=18" \
--small \
--iconsize 120 \

    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

        if [ "$dialogResults" = 0 ]; then
            echo "Opening support URL."
            open $supportURL
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
