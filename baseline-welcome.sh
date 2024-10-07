#!/bin/zsh

#Baseline welcome script

dialogPath="/usr/local/bin/dialog"

function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}

dialogTitle="Let's set up your computer"
dialogMessage="This tool will install most of the programs and apps that you'll need to get started.  \n\nWhile we install these programs, we'll also configure your computer with all the right settings.  \n\nIf at any time an error message pops up, please contact IT for guidance."
dialogIcon="SF=play.laptopcomputer,color=blue,weight=medium"
dialogInfoBoxContent="### Computer Name  \n{computername}  \n### Username \n{username}  \n### Serial number  \n{serialnumber}"
dialogInfoText="This is an official tool from JWA IT."


dialogCommandFile="/var/tmp/dialog.log"

# Button 1 Text
button1text="Continue"

 "$dialogPath" \
    --title "$dialogTitle" \
    --message "$dialogMessage" \
    --icon "$dialogIcon" \
    --infobox "$dialogInfoBoxContent" \
    --infotext "$dialogInfoText" \
    --iconalpha 1.0 \
    --ontop "true" \
    --button1text "$button1text" \
    --timer 30 \
    --hidetimerbar \
    --height 50% \
    
    #Very important that this part comes immediately after the dialog command
    dialogResults=$?

    echo "Dialog exited with the following code: $dialogResults"

    if [ "$dialogResults" = 0 ]; then
        echo "User selected continue, Baseline proceeding as normal"
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
