#!/bin/bash
#Cek Port
clear
echo -e ""
echo -e "================"
echo -e "|   Cek Port   |"
echo -e "----------------"
echo -e ""
echo -e "List :"
echo -e ""
echo -e "[1] Dropbear"
echo -e "[2] OpenSSH"
echo -e "[3] Stunnel"
echo -e "[4] OpenVPN"
echo -e "[5] Squid Proxy"
echo -e "[6] Nginx"
echo -e ""
read -p "Mana yang ingin anda pilih : " Jawaban

        #Dropbear
        if [[ $Jawaban =~ ^([1])$ ]]
                then
                        echo -e ""
                        echo -e "================"
                        echo -e "|   Dropbear   |"
                        echo -e "----------------"
                        echo -e ""
                        netstat -tunlp | grep dropbear
                        echo -e ""
                else
                        echo
        fi

        #OpenSSH
        if [[ $Jawaban =~ ^([2])$ ]]
                then
                        clear
                        echo -e ""
                        echo -e "==============="
                        echo -e "|   OpenSSH   |"
                        echo -e "---------------"
                        echo -e ""
                        netstat -tunlp | grep ssh
                        echo -e ""
                else
                        echo
        fi

        #Stunnel
        if [[ $Jawaban =~ ^([3])$ ]]
                then
                        clear
                        echo -e ""
                        echo -e "==============="
                        echo -e "|   Stunnel   |"
                        echo -e "---------------"
                        echo -e ""
                        netstat -tunlp | grep stunnel4
                        echo -e ""
                else
                        echo
        fi

        #OpenVPN
        if [[ $Jawaban =~ ^([4])$ ]]
                then
                        clear
                        echo -e ""
                        echo -e "==============="
                        echo -e "|   OpenVPN   |"
                        echo -e "---------------"
                        echo -e ""
                        netstat -tunlp | grep openvpn
                        echo -e ""
                else
                        echo
        fi

        #Squid Proxy
        if [[ $Jawaban =~ ^([5])$ ]]
                then
                        clear
                        echo -e ""
                        echo -e "==================="
                        echo -e "|   Squid Proxy   |"
                        echo -e "-------------------"
                        echo -e ""
                        netstat -tunlp | grep squid
                        echo -e ""
                else
                        echo
        fi

        #Nginx
        if [[ $Jawaban =~ ^([6])$ ]]
                then
                        clear
                        echo -e ""
                        echo -e "============="
                        echo -e "|   Nginx   |"
                        echo -e "-------------"
                        echo -e ""
                        netstat -tunlp | grep nginx
                        echo -e ""
                else
                        echo
        fi