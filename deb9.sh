# install nginx
apt-get -y install nginx php-fpm php-cli

# Get the "public" interface from the default route
NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
  # initializing var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/aldiblues/$MYIP/g";

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -p
# folder iptables
mkdir -p /etc/iptables

# install openvpn
apt-get install -y openvpn easy-rsa iptables openssl ca-certificates gnupg
apt-get install -y net-tools
cp -r /usr/share/easy-rsa /etc/openvpn
cd /etc/openvpn
cd easy-rsa


cp openssl-1.0.0.cnf openssl.cnf
source ./vars
./clean-all
source vars
rm -rf keys
./clean-all
./buld-ca
./buld-key-server server
./pkitool --initca
./pkitool --server server
./pkitool client
./build-dh
cp keys/ca.crt /etc/openvpn
cp keys/server.crt /etc/openvpn
cp keys/server.key /etc/openvpn
cp keys/dh2048.pem /etc/openvpn
cp keys/client.key /etc/openvpn
cp keys/client.crt /etc/openvpn

echo 'port 1194
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-tcp-1194.log
verb 3' >/etc/openvpn/server-tcp-1194.conf

echo 'port 9994
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
server 10.9.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-tcp-9994.log
verb 3' >/etc/openvpn/server-tcp-9994.conf

echo 'port 25000
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
server 20.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-udp-25000.log
verb 3' >/etc/openvpn/server-udp-25000.conf

systemctl enable openvpn
service openvpn restart

	cd
# membuat config untuk client
 wget -O /var/www/html/myvpn-tcp-1194.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-tcp-1194.ovpn"
 wget -O /var/www/html/myvpn-tcp-9994.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-tcp-9994.ovpn"
 wget -O /var/www/html/myvpn-ssl-2905.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-ssl-2905.ovpn"
 wget -O /var/www/html/myvpn-ssl-9443.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-ssl-9443.ovpn"
 wget -O /var/www/html/myvpn-udp-25000.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-udp-25000.ovpn"
 
sed -i $MYIP2 /var/www/html/myvpn-tcp-1194.ovpn
sed -i $MYIP2 /var/www/html/myvpn-tcp-9994.ovpn
sed -i $MYIP2 /var/www/html/myvpn-ssl-9443.ovpn
sed -i $MYIP2 /var/www/html/myvpn-ssl-2905.ovpn
sed -i $MYIP2 /var/www/html/myvpn-udp-25000.ovpn

apt-get install -y zip
cd /var/www/html

# input ca
{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>myvpn-tcp-1194.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>myvpn-tcp-9994.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>myvpn-ssl-9443.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>myvpn-ssl-2905.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>myvpn-udp-25000.ovpn

# zip config
zip myvpn-config.zip myvpn-tcp-1194.ovpn myvpn-tcp-9994.ovpn myvpn-ssl-9443.ovpn myvpn-ssl-2905.ovpn myvpn-udp-25000.ovpn

apt-get install -y iptables iptables-persistent netfilter-persistent

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 20.8.0.0/24 -o $NIC -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

service openvpn restart

# done

#detail nama perusahaan
country=ID
state=Indonesia
locality=Bandung
organization=xShinGroup
organizationalunit=xShinPages
commonname=xShin
email=xshin3373@gmail.com

# simple password minimal
wget -O /etc/pam.d/common-password "https://github.com/xshin404/tunneling-deb9/blob/master/common/common-password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

#update
apt-get update -y

# install wget and curl
apt-get install -y wget curl

# remove unnecessary files
apt -y autoremove
apt -y autoclean
apt -y clean

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# set repo
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add jcameron-key.asc

# update
apt-get update -y

# install webserver
apt-get install -y nginx

# install neofetch
apt-get update -y
apt-get -y install gcc
apt-get -y install make
apt-get -y install cmake
apt-get -y install git
apt-get -y install screen
apt-get -y install unzip
apt-get -y install curl
apt-get -y install net-tools
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
make PREFIX=/usr/local install
make PREFIX=/boot/home/config/non-packaged install
make -i install
apt-get -y install neofetch
cd
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "" >> .profile
echo "echo =======================" >> .profile
echo "echo |   Tunneling Deb 9   |" >> .profile
echo "echo | 	  By xShin       |" >> .profile
echo "echo -----------------------" >> .profile
rm -rf neofetch
# update repo
apt-get -y update

# install webserver
cd
rm /etc/nginx/sites-enabled/default
wget -O /etc/nginx/sites-enabled/default "https://github.com/xshin404/tunneling-deb9/blob/master/nginx/default"

/etc/init.d/nginx restart
systemctl restart nginx
# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://github.com/xshin404/tunneling-deb9/blob/master/badvpn/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500

cd
wget -O /usr/bin/badvpn-udpgw "https://github.com/xshin404/tunneling-deb9/blob/master/badvpn/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

# setting port ssh
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 444' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 80 -p 236"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
apt-get -y install squid3
wget -O /etc/squid/squid.conf "https://github.com/xshin404/tunneling-deb9/blob/master/squid/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf

service squid restart
# setting vnstat
apt-get -y install vnstat
vnstat -u -i $NIC
service vnstat restart 

# install webmin
cd
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.910_all.deb
dpkg --install webmin_1.910_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm -f webmin_1.910_all.deb
/etc/init.d/webmin restart

# install stunnel
apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 127.0.0.1:143

[dropbear]
accept = 943
connect = 127.0.0.1:80

[dropbear]
accept = 9443
connect = 127.0.0.1:1194

[dropbear]
accept = 2905
connect = 127.0.0.1:9994

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
rm -f key.pem
rm -f cert.pem
# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# install fail2ban
cdLEDinstall fail2ban
apt-get -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# xml parser
cd
apt-get install -y libxml-parser-perl

# banner /etc/issue.net
wget -O /etc/issue.net "https://github.com/xshin404/tunneling-deb9/blob/master/banner/issue.net"
sed -i 's@#Banner@Banner@g' /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.com"@g' /etc/default/dropbear

# download script
cd /usr/bin
wget -O menu "https://github.com/xshin404/tunneling-deb9/blob/master/menu/menu.sh"
wget -O usernew "https://github.com/xshin404/tunneling-deb9/blob/master/menu/usernew.sh"
wget -O trial "https://github.com/xshin404/tunneling-deb9/blob/master/menu/trial.sh"
wget -O member "https://github.com/xshin404/tunneling-deb9/blob/master/menu/member.sh"
wget -O delete "https://github.com/xshin404/tunneling-deb9/blob/master/menu/delete.sh"
wget -O cek "https://github.com/xshin404/tunneling-deb9/blob/master/menu/cek.sh"
wget -O restart "https://github.com/xshin404/tunneling-deb9/blob/master/menu/restart.sh"
wget -O speedtest "https://github.com/xshin404/tunneling-deb9/blob/master/menu/speedtest"
wget -O info "https://github.com/xshin404/tunneling-deb9/blob/master/menu/info.sh"
wget -O about "https://github.com/xshin404/tunneling-deb9/blob/master/menu/about.sh"
wget -O onkill "https://github.com/xshin404/tunneling-deb9/blob/master/menu/onkill.sh"
wget -O offkill "https://github.com/xshin404/tunneling-deb9/blob/master/menu/offkill.sh"
wget -O live "https://github.com/xshin404/tunneling-deb9/blob/master/menu/live.sh"
wget -o perpanjang "https://github.com/xshin404/tunneling-deb9/blob/master/menu/perpanjang.sh"
wget -o cekmemory "https://github.com/xshin404/tunneling-deb9/blob/master/menu/cekmemory.py"
wget -o cekport "https://github.com/xshin404/tunneling-deb9/blob/master/menu/cekport.sh"


echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x onkill
chmod +x offkill
chmod +x live
chmod +x perpanjang
chmod +x cekmemory
chmod +x cekport

# finishing
cd
systemctl restart nginx
service openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/sshd restart
service dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
service squid restart
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
estartf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/deb9.sh

# finishing
clear
neofetch
netstat -tunlp
