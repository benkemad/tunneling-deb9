#!/bin/bash
#Script auto create user SSH
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
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "Success Created Account !"
sleep 0.5
echo -e ""
echo -e "========================="
echo -e "|     Account Details   |"
echo -e "-------------------------"
echo -e ""
echo -e "Host               : $IP"
echo -e "Username           : $Login"
echo -e "Password           : $Pass"
echo -e "Expiration         : $exp"
echo -e "Port OpenSSH       : 22,444"
echo -e "Port Dropbear      : 143,80"
echo -e "Port SSL           : 443"
echo -e "Port Squid         : 80,8000,8989,8080"
echo -e "BadVPN UDPGW       : 7200,7300"
echo -e "OpenVPN TCP        : 1194"
echo -e "OpenVPN SSL        : 2905,9443"
echo -e "OpenVPN UDP        : 25000"
echo -e "OpenVPN File TCP   : http://$IP:81/client-tcp-1194.ovpn"
echo -e "                     http://$IP:81/client-tcp-9994.ovpn"
echo -e "OpenVPN File SSL   : http://$IP:81/client-ssl-2905.ovpn"
echo -e "                     http://$IP:81/client-ssl-9443.ovpn"
echo -e "OpenVPN File UDP   : http://$IP:81/client-udp-25000.ovpn"
echo -e "OpenVPN File ZIP   : http://$IP:81/client-config.zip"
echo -e ""