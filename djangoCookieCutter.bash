#!/bin/sh

stty -echoctl # hide ^C

appNames=()
function trap_ctrlc ()
{
    clear
    mkdir APPS
    # cd "APPS" || exit 2
    echo "install ${#appNames[@]} apps :: ${appNames[*]}"
    for appIndex in "${!appNames[@]}"; do
        app="${appNames[$appIndex]}"
        echo "install app -> $app"
        python3 manage.py startapp "$app"
        mv "$app" ./APPS
    done
    echo "Doing cleanup"
    exit 2
}

trap "trap_ctrlc" SIGINT

clear


echo "install depenedenvies"
python3 -m pip install django
python3 -m pip install djangorestframework
clear
echo "start creating files ..."
django-admin startproject SERVER .
echo "main file generated"

echo "insert your app name (finish with ctrl+C)"
while true;do
    read -r -p "insert app name : " appName
    appNames+=("$appName")
done