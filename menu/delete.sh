#!/bin/bash
#Script to remove SSH & OpenVPN users
clear
echo -e ""
echo -e "================================"
echo -e "|   HAPUS AKUN SSH & OpenVPN   |"
echo -e "--------------------------------"
echo -e ""
read -p "Masukkan Username yang akan di hapus : " Users
echo -e ""
if getent passwd $Users > /dev/null 2>&1;
        then
                userdel $Users
                echo -e "========================================================="
                echo -e "|   Success Username ( $Users ) berhasil di hapus.   |"
                echo -e "---------------------------------------------------------"
                echo -e ""
        else
                echo -e "======================================================"
                echo -e "|   Failed Username ( $Users ) tidak ditemukan.   |"
                echo -e "------------------------------------------------------"
                echo -e
                echo -e "Silahkan cek Username dengan perintah 'member'."
                echo -e ""
fi
