#!/bin/sh

stty -echoctl # hide ^C

appNames=()
function trap_ctrlc ()
{
    clear
    echo "install ${#appNames[@]} apps : ${appNames[*]}"
    for app in $appNames
    do
        echo "install app -> $app"
    done
    echo "Doing cleanup"
    exit 2
}

trap "trap_ctrlc" SIGINT

clear
echo "insert your app name (finish with ctrl+C)"
while true;do
    read -r -p "insert app name :" appName
    appNames+=("$appName")
done