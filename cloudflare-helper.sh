#!/bin/sh

dialogPath="/usr/local/bin/dialog"

function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}

dialogTitle="Change Cloudflare mode"
dialogMessage="This tool is used to switch Cloudflare WARP modes for troubleshooting.  \n\n Use DNS-over-HTTPS (DoH) mode if you're having trouble connecting to certain networks.  \n\nOnce you're done, make sure to reset it to the standard WARP mode."
dialogIcon="SF=cloud.fill,color=orange,weight=medium"

dialogCommandFile="/var/tmp/dialog.log"

# Button 1 Text
button1text="Switch to DoH"
button2text="Reset to WARP"

 "$dialogPath" \
    --title "$dialogTitle" \
    --message "$dialogMessage" \
    --icon "$dialogIcon" \
    --iconalpha 1.0 \
    --button1text "$button1text" \
    --button2text "$button2text" \
    --buttonstyle stack \
    --width 600 \
    --height 400 \
    
    #Very important that this part comes immediately after the dialog command
    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        warp-cli mode doh
        echo "WARP mode changed to DoH"

    elif [ "$dialogResults" = 2 ]; then
        warp-cli mode warp+doh
        echo "WARP mode changed to WARP+DoH"

    elif [ "$dialogResults" = 10 ]; then
        echo "Exit key was used - user was prompted to exit."
    else
        echo "Dialog exited with an unexpected code."
        echo "Could be an error in the dialog command"
        echo "Could be the process killed somehow."
        echo "Exit with an error code."
        exit "$dialogResults"
    fi

exit
