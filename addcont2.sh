#!/bin/bash

if [ $# -lt 3 ]
then
    echo "Err: Usage: addcont <ID> <FULL_NAME> <Phone-No.>"
    exit 1
fi

if [[ $1 != [a-z][0-9][0-9][0-9][0-9] ]]
then
    echo "Err: ID format has to be as in \"c1234\""
    exit 2
fi

if ! [ -z $(grep $1 contacts.txt) ]
then
    echo "Err: ID is already taken. Please make a new one!"
    exit 6 #I knew about this later on
fi

ID=$1

shift #Removing stored ID value

NAM="" #Full name

while [ $# -ne 1 ] # A loop that adds up the components of full name
do #stops when number of arguments left is 1 (only the the phone argument left)
    NAM="$NAM"_$1
#    echo $NAM #test test
    shift #Decrementing arguments and thus $#
done

NAM=$(echo $NAM | sed s/^_/""/) #Removing the first '_' resulting from concatenating NAM (name) components

if [[ $1 != [0][0][9][7][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9] ]]
then
    echo "Err: Phone number has to be of the format 0097##-#####"
    exit 4
fi

if [ $(echo $NAM | tr "_" " " | wc -w) -lt 2 ] #Replacing underscore with spaces if exists
then
    echo "Err: Name has to be at least 2 words!" #Could be more than 2 words due to all the "Abu"s and "Abd"s out there.
    exit 3
fi

if ! [ -z $(echo $NAM | grep [0-9]) ]
then
    echo "Err: Names can't have numbers, right?!"
    exit 5
fi



PHON=$1
INIT=$(echo $NAM | cut -d_ -f1 | tr "A-Z" "a-z" | cut -c1) #Initial
LINIT=$(echo $NAM | tr "_" " " | cut -d" " -f2 | tr "A-Z" "a-z" |  cut -c1) #First letter of the last name #See comment in line 23
DIGS=$(echo $ID | cut -c1,5) #First and last digits of the ID
EMAIL="$INIT$LINIT$DIGS@birzeit.edu"
echo $ID:$NAM:$PHON:$EMAIL>>contacts.txt
exit 0

