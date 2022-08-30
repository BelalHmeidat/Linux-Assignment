#!/bin/bash

if [ $# -ne 3 ]
then
    echo "ERR: Usage: addcont <ID> <FULL_NAME> <Phone-No.>"
    exit 1
elif [[ $1 != [a-z][0-9][0-9][0-9][0-9] ]]
then
    echo "ERR: ID format has to be as in \"c1234\""
    exit 2
elif [ $(echo $2 | tr "_" " " | wc -w) -lt 2 ] #Replacing underscore with spaces if exists
then
    echo "ERR: Name has to be at least 2 words!" #Could be more than 3
    exit 3
elif [[ $3 != [0][0][9][7][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9] ]]
then
    echo "ERR: Phone number has to be of the format 0097##-#####"
    exit 4
else
    INIT=$(echo $2 | cut -d_ -f1 | tr "A-Z" "a-z" | cut -c1) #Initial
    LINIT=$(echo $2 | tr "_" " " | cut -d" " -f2 | tr "A-Z" "a-z" |  cut -c1) #First letter of the last name #See comment in line 11
    DIGS=$(echo $1 | cut -c1,5) #First and last digits of the ID
    EMAIL="$INIT$LINIT$DIGS@birzeit.edu"
    echo $1:$2:$3:$EMAIL>>contacts.txt
    exit 0
fi
