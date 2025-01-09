#!/bin/sh

dialogPath="/usr/local/bin/dialog"

function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}

dialogTitle="Change Cloudflare mode"
dialogMessage="This tool is used to switch Cloudflare WARP modes for troubleshooting.  \n\n Use DNS-over-HTTPS mode if you're having trouble in the default mode."
dialogIcon="SF=play.laptopcomputer,color=blue,weight=medium"
dialogBannerImage="https://resources.jwainfrastructure.com/img/pdx-monochrome.png"


dialogCommandFile="/var/tmp/dialog.log"

# Button 1 Text
button1text="Switch to DoH"

 "$dialogPath" \
    --title "$dialogTitle" \
    --message "$dialogMessage" \
    --icon "$dialogIcon" \
    --centericon \
    --iconalpha 1.0 \
    --ontop "true" \
    --button1text "$button1text" \
    --height 50% \
    --blurscreen \
    --button1
    
    #Very important that this part comes immediately after the dialog command
    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "User selected continue, Baseline proceeding as normal"
        warp-cli mode doh
        echo "WARP mode changed to DoH"

    elif [ "$dialogResults" = 4 ]; then
        echo "Timer ran out, Baseline proceeding as normal"
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
