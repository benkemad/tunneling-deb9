#!/bin/bash
#Script auto create trial user SSH
#will expired after 1 day
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
echo -e ""
echo -e "======================="
echo -e "|   Account Details   |"
echo -e "-----------------------"
echo -e ""
echo -e "Host             : $IP"
echo -e "Username         : $Login"
echo -e "Password         : $Pass"
echo -e "Hari             : $hari"
echo -e "Port OpenSSH     : 22,444"
echo -e "Port Dropbear    : 143,80"
echo -e "Port SSL         : 443"
echo -e "Port Squid       : 80,8000,8989,8080"
echo -e "BadVPN UDPGW     : 7200,7300"
echo -e "Port OpenVPN TCP : 1194"
echo -e "Port OpenVPN SSL : 2905,9443"
echo -e "Port OpenVPN UDP : 25000"
echo -e "OpenVPN File TCP : http://$IP:81/client-tcp-1194.ovpn"
echo -e "                   http://$IP:81/client-tcp-9994.ovpn"
echo -e "OpenVPN File SSL : http://$IP:81/client-ssl-2905.ovpn"
echo -e "                   http://$IP:81/client-ssl-9443.ovpn"
echo -e "OpenVPN File UDP : http://$IP:81/client-udp-25000.ovpn"
echo -e "OpenVPN File ZIP : http://$IP:81/client-config.zip"
echo -e ""