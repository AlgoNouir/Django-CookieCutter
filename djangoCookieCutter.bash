#!/bin/sh

stty -echoctl # hide ^C

appNames=()
function trap_ctrlc ()
{
    clear
    echo "install ${#appNames[@]} apps :: ${appNames[*]}"
    for appIndex in "${!appNames[@]}"; do
        app="${appNames[$appIndex]}"
        echo "install app -> $app"
    done
    echo "Doing cleanup"
    exit 2
}

trap "trap_ctrlc" SIGINT

clear

python3 -m pip install django
python3 -m pip install djangorestframework
django-admin startproject SERVER .

echo "insert your app name (finish with ctrl+C)"
while true;do
    read -r -p "insert app name : " appName
    appNames+=("$appName")
done