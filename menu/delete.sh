#!/bin/bash
#Delete Account
clear
echo -e ""
echo -e "======================"
echo -e "|   Delete Account   |"
echo -e "----------------------"
echo -e ""
read -p "Username : " Users
echo -e ""
read -p "Are you sure you want to delete $Users ? [Y/n] " Jawaban
echo -e ""
if [[ $Jawaban =~ ^([yY])$ ]]
        then
                if getent passwd $Users > /dev/null 2>&1;
                        then
                                userdel $Users
                                echo -e "========================================================="
                                echo -e "|   Username ($Users) has been successfully deleted.   |"
                                echo -e "---------------------------------------------------------"
                                echo -e ""
                        else
                                echo -e "======================================"
                                echo -e "|   Username ( $Users ) not found.   |"
                                echo -e "--------------------------------------"
                                echo -e
                                echo -e "Please check Username with the 'member' command."
                                echo -e ""
                fi
        else
                echo -e ""
fi
