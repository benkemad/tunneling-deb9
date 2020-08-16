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
./build-ca
./build-key-server server
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

# Cloning Script
git clone https://github.com/xshin404/tunneling-deb9

# membuat config untuk client
# wget -O /var/www/html/myvpn-tcp-1194.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-tcp-1194.ovpn"
# wget -O /var/www/html/myvpn-tcp-9994.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-tcp-9994.ovpn"
# wget -O /var/www/html/myvpn-ssl-2905.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-ssl-2905.ovpn"
# wget -O /var/www/html/myvpn-ssl-9443.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-ssl-9443.ovpn"
# wget -O /var/www/html/myvpn-udp-25000.ovpn "https://github.com/xshin404/tunneling-deb9/blob/master/client/myvpn-udp-25000.ovpn"
 
#sed -i $MYIP2 /var/www/html/myvpn-tcp-1194.ovpn
#sed -i $MYIP2 /var/www/html/myvpn-tcp-9994.ovpn
#sed -i $MYIP2 /var/www/html/myvpn-ssl-9443.ovpn
#sed -i $MYIP2 /var/www/html/myvpn-ssl-2905.ovpn
#sed -i $MYIP2 /var/www/html/myvpn-udp-25000.ovpn

# Masuk File Repository
cd tunneling-deb9/client

#Membuat Config OpenVPN Client
mv myvpn-tcp-1194.ovpn /var/www/html
mv myvpn-tcp-9994.ovpn /var/www/html
mv myvpn-ssl-2905.ovpn /var/www/html
mv myvpn-ssl-9443.ovpn /var/www/html
mv myvpn-udp-25000.ovpn /var/www/html

cd

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
zip ovpn-config.zip myvpn-tcp-1194.ovpn myvpn-tcp-9994.ovpn myvpn-ssl-9443.ovpn myvpn-ssl-2905.ovpn myvpn-udp-25000.ovpn

apt-get install -y iptables iptables-persistent netfilter-persistent

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 20.8.0.0/24 -o $NIC -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

service openvpn restart

# done