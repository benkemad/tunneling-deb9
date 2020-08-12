#!/bin/bash
# off autokill
clear
echo -e ""
echo -e "===================="
echo -e "|   OFF AUTOKILL   |"
echo -e "--------------------"
echo -e ""
echo -e "   Waiting ..."
clear
rm -f /usr/bin/autokill
rm -f /usr/bin/tendang

        if rm -f /usrbin/autokill
                then
                        echo ""
			echo "==============="
                        echo "|   Success   |"
			echo "---------------"
                        sleep 1
                        clear
                        echo ""
			echo "==================================="
                        echo "|   AUTO KILL BERHASIL BERHENTI   |"
                        echo "-----------------------------------"
		else
                        echo ""
			echo "=============="
                        echo "|   Failed   |"
			echo "--------------"
                        sleep 1
                        clear
                        echo ""
			echo "================================="
                        echo "|   AUTO KILL GAGAL BEHERNETI   |"
			echo "---------------------------------"
        fi
echo ""
