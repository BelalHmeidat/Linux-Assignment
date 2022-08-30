#!/bin/bash

if ! [ -f contacts.txt ]
then
    echo "Warning! File doesn't exist. Created a new file.."
    touch contacts.txt
    ./$0
fi

echo "
    1. Add Contact
    2. Modify Contact
    3. Search Contacts
    4. Exit

Choose an option:"
    
    
read OPT #option

case $OPT in
    1)  while true #A loop that runs the same script again in case it returned an error
        do
            echo "Enter <ID> <Full_Name> <Phone-No.>"
            read FULL #full info
            ./addcont2.sh $FULL
            if [ $? -eq 0 ] #Runs the previous script till successful
            then
                break
            fi
        done
        ./$0 #Goes back to the main menu
        ;;
        
    2)  ./modcont.sh
        ./$0
        ;;
        
    3)
        if ! [ -s contacts.txt ]
        then
            echo "Err: File is empty! Please add some enteries!"
        else
            while true #Same idea as in line 22
            do
                echo "Enter the keyword: "
                read STR
                ./searcont.sh $STR
                if [ $? -eq 0 ]
                then
                    break
                fi
            done
        fi
        ./$0
        ;;
        
    4) exit 0
        ;;

    *)
        echo "Err: Not a valid option!"
        ./$0 #pull up menu again
        ;;
esac
