#!/bin/bash
#Script auto create user SSH
clear
echo ""
echo -e "=========================="
echo -e "|   Create SSH Account   |"
echo -e "--------------------------"
echo -e ""
read -p "Masukan Username      : " Login
read -p "Masukan Password      : " Pass
read -p "Masukan Expired (day) : " Activetime

IP=$(wget -qO- ipv4.icanhazip.com);
useradd -e `date -d "$Activetime days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
clear
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "Success Created Account !"
sleep 0.5
clear
echo -e ""
echo -e "========================="
echo -e "|     Account Details   |"
echo -e "-------------------------"
echo -e ""
echo -e "Host           : $IP"
echo -e "Username       : $Login"
echo -e "Password       : $Pass"
echo -e "Expiration     : $exp"
echo -e "Port OpenSSH   : 22,444"
echo -e "Port Dropbear  : 143,80,236"
echo -e "Port SSL       : 443,943"
echo -e "BadVPN UDPGW   : 7200,7300"
echo -e "Squid Proxy    : 8000,8080,8989"
echo -e "OpenVPN TCP    : 1194"
echo -e "OpenVPN SSL    : 2905,9443"
echo -e "OpenVPN UDP    : 25000"
echo -e "OpenVPN Config : http://$IP:81/ovpn-config.zip"
echo -e ""