#!/bin/bash
#Script Perpanjang User SSH

clear
echo -e ""
echo -e "====================================="
echo -e "|   PERPANJANG AKUN SSH & OpenVPN   |"
echo -e "-------------------------------------"
echo -e ""
read -p "Username : " Login
read -p "Password : " Pass
echo -e "Note : masa aktif sekarang + masa aktif-"
echo -e "       yang baru."
echo -e "       contoh masa aktif sekarang 2-"
echo -e "       masa aktif baru 10 '2+10=12'"
echo -e "       lalu isikan penambahan masa aktif 12"
echo -e ""
read -p "Penambahan Masa Aktif (hari): " masaaktif
userdel $Login
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Waiting . . ."
sleep 1
clear
echo -e "Username : $Login"
echo -e "Password : $Pass"
echo -e ""
echo -e "===================================================================="
echo -e "|   Username ( $Login ) berhasil di perpanjang sampai $exp   |"
echo -e "--------------------------------------------------------------------"