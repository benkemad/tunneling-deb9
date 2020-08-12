#!/bin/bash
# on autokill
clear
echo -e ""
echo -e "===================="
echo -e "|   ON AUTOKILL   |"
echo -e "--------------------"
echo -e ""
echo -e "Waiting ..."
echo -e ""
wget -O /usr/bin/autokill "https://github.com/potatonc/server/raw/master/freeze/autokill.sh"
chmod +x /usr/bin/autokill
        if chmod +x /usr/bin/autokill
                then
                        autokill
                        echo -e ""
                        echo -e "==============="
                        echo -e "|   Success   |"
                        echo -e "---------------"
                        echo -e ""
                        echo -e "================================"
                        echo -e "|   AUTO KILL BEHRASIL AKTIF   |"
                        echo -e "--------------------------------"
                        echo ""
                else
                        echo -e ""
                        echo -e "=============="
                        echo -e "|   Failed   |"
                        echo -e "--------------"
                        echo -e ""
                        echo -e "============================="
                        echo -e "|   AUTO KILL GAGAL AKTIF   |"
                        echo -e "-----------------------------"
                        echo ""
        fi
echo ""
