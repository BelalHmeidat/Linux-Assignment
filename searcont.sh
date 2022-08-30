#!/bin/bash

if [ -z $1 ]
then
    echo "Err: Keyword can't be blank!"
    exit 2
fi

if ! [[ -z $(echo $1 | tr "_" " " | tr "-" " " | grep -i [^a-z]) ]] #Checking if the name has numbers or illegal characters
then
    echo "Err: Names can't have numbers!"
    exit 3
fi

if [ -z $(cut -d: -f2 contacts.txt | cut -d_ -f2 | grep -i  $1) ]
then
    echo "No entery found!"
    exit 0 #Not an error
fi

echo $(grep -i $1 contacts.txt | sort -t: -k2 -i | tr ":" " "| tr "_" " ") #Removing separators
exit 0
