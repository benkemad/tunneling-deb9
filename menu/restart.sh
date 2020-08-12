#!/bin/bash
# Script restart service dropbear, webmin, squid3, openvpn, openssh
clear
echo -e ""
echo -e "============================="
echo -e "|   RESTART PORT DROPBEAR   |"
echo -e "-----------------------------"
service dropbear restart
        if service dropbear restart
                then
                        echo "===================================="
                        echo "|   DROPBEAR BERHASIL DI RESTART   |"
                        echo "------------------------------------"
                else
                        echo "================================="
                        echo "|   DROPBEAR GAGAL DI RESTART   |"
                        echo "---------------------------------"
        fi
echo ""
echo -e "======================="
echo -e "|   RESTART OPENVPN   |"
echo -e "-----------------------"
service openvpn restart
        if service openvpn restart
                then
                        echo "==================================="
                        echo "|   OPENVPN BERHASIL DI RESTART   |"
                        echo "-----------------------------------"
                else
                        echo "================================"
                        echo "|   OPENVPN GAGAL DI RESTART   |"
                        echo "--------------------------------"
         fi
echo ""
echo -e "============================"
echo -e "|   RESTART PORT OPENSSH   |"
echo -e "----------------------------"
service ssh restart
        if service ssh restart
                then
                        echo "==================================="
                        echo "|   OPENSSH BERHASIL DI RESTART   |"
                        echo "-----------------------------------"
                else
                        echo "================================"
                        echo "|   OPENSSH GAGAL DI RESTART   |"
                        echo "--------------------------------"
        fi
echo -e "=================================="
echo -e "|   RESTART PORT STUNNEL / SSL   |"
echo -e "----------------------------------"
/etc/init.d/stunnel4 restart
        if /etc/ini.d/stunnel4 restart
                then
                        echo "========================================="
                        echo "|   STUNNEL / SSL BERHASIL DI RESTART   |"
                        echo "-----------------------------------------"
                else
                        echo "======================================"
                        echo "|   STUNNEL / SSL GAGAL DI RESTART   |"
                        echo "--------------------------------------"
        fi
netstat -tunlp
echo -e ""
