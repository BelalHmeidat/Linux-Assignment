#!/bin/bash
if ! [ -s contacts.txt ]
then
    echo "Err: File is empty! Please add some enteries!"
    exit 1
fi

echo "
    a. Delete Contact
    b. Edit Contact's First Name
    c. Edit Contact's Phone No.
    d. Exit

Choose an option: "

read OPT
case $OPT in
    a|A)
        rm contacts.txt
        touch contacts.txt
        echo "Deleted all enteries."
        ;;
    b|B)
        while true
        do
            echo "Enter ID of the contact: "
            read ID
            RES=$(grep -i $ID contacts.txt)
            if [ -z $RES ]
            then
                echo "Err: No enteries found!"
                continue
            else
                FNAM=$(echo $RES | cut -d: -f2 | cut -d_ -f1)
                LNAM=$(echo $RES | cut -d: -f2 | cut -d_ -f2)
                PHON=$(echo $RES | cut -d: -f3)
                EMAIL=$(echo $RES | cut -d: -f4)
                echo "Found: $ID $FNAM"
                echo "What do you want to change it to?"
                while true
                do
                    read NEW
                    if [ -z $NEW ]
                    then
                        echo "Err: First name can't be empty! Let's try again:"
                    elif ! [ -z $(echo $NEW | grep [0-9]) ] #A string check for numbers
                    then
                        echo "Err: Name can't contain numbers! Let's try again:"
                    else break
                    fi
                done
                FNAM=$NEW
                NEW=$ID:"$FNAM"_$LNAM:$PHON:$EMAIL #Quotes to prevent variables FNAM and LNAM to be read as one variable
                sed "s/$RES/$NEW/ig" contacts.txt >modcontacts.txt
                mv modcontacts.txt contacts.txt #sed doesn't write directly to the original file
                break
            fi
        done
        ;;
        
    c|C)
        while true
        do
            echo "Enter ID of the contact: "
            read ID
            RES=$(grep -i $ID contacts.txt)
            if [ -z $RES ]
            then
                echo "Err: No enteries found!"
                continue
            else
                NAM=$(echo $RES | cut -d: -f2)
                PHON=$(echo $RES | cut -d: -f3)
                EMAIL=$(echo $RES | cut -d: -f4)
                echo "Found: $ID $PHON"
                echo "What do you want to change it to?"
                read NEW
                while [[ $NEW != [0][0][9][7][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9] ]] #Checking phone number format
                do
                    echo "Err: Phone no. format is incorrect! Let's try agian:"
                    read NEW
                done
                PHON=$NEW
                NEW=$ID:$NAM:$PHON:$EMAIL
                sed "s/$RES/$NEW/ig" contacts.txt > modcontacts.txt
                mv modcontacts.txt contacts.txt
                break
            fi
        done
        ;;
    d|D) exit 0
        ;;
        
    *) ./$0
        ;;
        
    esac
