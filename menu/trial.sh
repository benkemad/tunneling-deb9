#!/bin/bash
#Script auto create trial user SSH
#will expired after 1 day
clear
echo ""
echo -e "================================"
echo -e "|   Create Trial SSH Account   |"
echo -e "--------------------------------"
echo -e ""
IP=$(wget -qO- ipv4.icanhazip.com);

Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=`</dev/urandom tr -dc a-f0-9 | head -c9`

useradd -e `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "Success Created Trial Account !"
sleep 1
clear
echo -e ""
echo -e "======================="
echo -e "|   Account Details   |"
echo -e "-----------------------"
echo -e "Host           : $IP"
echo -e "Username       : $Login"
echo -e "Password       : $Pass\n"
echo -e "Hari           : $hari\n"
echo -e "Port OpenSSH   : 22,444"
echo -e "Port Dropbear  : 143,80,236"
echo -e "Port Squid     : 8080,8000,8989"
echo -e "OpenVPN TCP    : 1194"
echo -e "OpenVPN SSL    : 2905,9443"
echo -e "OpenVPN UDP    : 25000"
echo -e "OpenVPN Config : http://$IP:81/myvpn-config.zip"
echo -e ""