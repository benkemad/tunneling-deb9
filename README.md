![Image](/image/v13.png)

### OS
* Debian 9

### Install
**For Update & Upgrade Binary**
```
apt-update && apt-upgrade
```
**Download / Install Git**
```
apt-get install git
```
**Cloning This Repo**
```
git clone https://github.com/xshin404/tunneling-deb9
```
**Open Folder "tunneling-deb9" & move deb9.sh to root**
```
cd tunneling-deb9 && mv deb9.sh /root or ..
```
**Execute Script**
```
chmod +x deb9.sh && ./deb9.sh
```

### What's New Version ?
* Fixed Bug On Squid Proxy
* Fixed Bug On OpenVPN
* Add New Fitur : contact, statport & update
* Update README.md on Repository to Minimalist
* Added Lolcat
* Added Confirm Before Create Account
* Added Config OpenVPN Instagram
* Open Reporting or Issues

### About Port
* OpenSSH               : 22 & 444
* Dropbear              : 143 & 80
* Stunnel / SSL         : 443
* Squid Proxy           : 8000, 8989 & 8080
* OpenVPN TCP           : 1194
* OpenVPN UDP           : 25000
* OpenVPN Stunnel / SSL : 2905 & 9443
* Badvpn - Udpgw        : 7300 & 7200

### Web Server
* Nginx http(s)://$IP:81/

### cPanel Server with Webmin
* Webmin http(s)://$IP:10000/

### Time Server
* Timezone : Asia/Jakarta

### Fitur Script
* menu
* usernew
* trial
* delete
* cek
* member
* live
* restart
* reboot
* speedtest
* cekmemory
* cekport
* statport
* update
* contact
* info
* about