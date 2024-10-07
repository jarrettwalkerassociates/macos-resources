#!/bin/zsh


#Writte
#Written by Trevor Sysock (@BigMacAdmin on Slack)

#Example script: How to capture button output and make actions based on the results
dialogPath="/usr/local/bin/dialog"

dialogCommandFile="/var/tmp/dialog.log"

button1text="Continue"

# execute a dialog command
function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    log_message "$@"
    sleep .1
}


var sequence2 

{
  "button2text" : "Cancel",
  "quitoninfo" : "true",
  "builder" : "true",
  "image" : [
    {
      "caption" : "",
      "imagename" : "\/Users\/jasonadle\/Desktop\/error.png"
    }
  ],
  "button1text" : "Continue",
  "infobutton" : "true",
  "title" : "Continue setting up your computer",
  "iconsize" : "150.0",
  "height" : "380.0",
  "button2" : "true",
  "messagealignment" : "center",
  "width" : "820.0",
  "message" : "Welcome back. Let’s keep setting up your computer."
}



/usr/local/bin/dialog \
--title "Example Script" \
--message "This is an exmaple of how to capture the exit code of a script, and then take action based on what button the user clicked." \
--icon "SF=bolt.circle color1=pink color2=blue" \
--button1text "Primary button exits 0" \
--button2text "Cancel button exits 2" \
--infobuttontext "Info button exits 3" \
--timer 10 \

#Very important that this part comes immediately after the dialog command
dialogResults=$?

echo "Dialog exited with the following code: $dialogResults"

if [ "$dialogResults" = 0 ]; then
    echo "Do the things you want when button1 is clicked"
elif [ "$dialogResults" = 2 ]; then
    echo "Do the things you want when button2 is clicked"
elif [ "$dialogResults" = 3 ]; then
    echo "Do the things you want when button3 (info button) is clicked"
elif [ "$dialogResults" = 4 ]; then
    echo "Do the things you want when a timer runs out"
elif [ "$dialogResults" = 10 ]; then
    echo "Do the things you want when the user used the quitkey combination"
else
    echo "Dialog exited with an unexpected code."
    echo "Could be an error in the dialog command"
    echo "Could be the process killed somehow."
    echo "Exit with an error code."
    exit "$dialogResults"
fi