#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ipvps > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ipvps | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ipvps | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

set-tdns(){
clear
cpath="/etc/openvpn/server/server-tcp-1194.conf"
cpath="default"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "|                 • SET DNS •                    |"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e " • Default DNS SET TO : 8.8.8.8  "
echo -e " • Current DNS  CONF  : $(cat /etc/resolv.conf | awk '{print $2}')"
echo -e " • Current DNS  HEAD  : $(cat /etc/resolvconf/resolv.conf.d/head | awk '{print $2}')"
echo ""
echo -e "   Press [ Ctrl+C ] • To-Exit"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -ne "Input your DNS : " controld
echo -ne "Input your DNS : "
read controld
    [[ -z $controld ]] && controld="8.8.8.8"
    [[ ! -f /etc/resolvconf/interface-order ]] && {
        apt install resolvconf
    }
    echo "nameserver $controld" >/etc/resolvconf/resolv.conf.d/head
    echo "nameserver $controld" >/etc/resolv.conf
    sed -i "/dhcp-option DNS/d" $cpath
    sed -i "/redirect-gateway def1 bypass-dhcp/d" $cpath
    cat >>$cpath <<END
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS $controld"
END

    [[ ! -f /usr/bin/jq ]] && {
        apt install jq
    }
    bash <(curl -sSL https://raw.githubusercontent.com/nympho687/kirik/main/ceknet.sh)
    echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
    read answer
    if [ "$answer" == "${answer#[Yy]}" ]; then
        exit 0
    else
        reboot
    fi
}

echo ""
read -p "Press Enter to Continue : "
sleep 1
menu-dns
fi
}

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "|                 • DNS MENU •                    |"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""

echo -e " [\e[36m10\e[0m] Install Temporary DNS"
echo -e " [\e[36m11\e[0m] Install Permanent DNS"
echo -e " [\e[36m12\e[0m] Reset Default DNS"
echo -e " [\e[36m13\e[0m] Check DNS Region"
echo -e ""
echo -e " [\e[36m00\e[0m] Back To Main Menu"
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
10)
    clear
    set-tdns
    ;;
11)
    clear
    set-dns
    ;;
12)
    clear
    reset-dns
    ;;
13)
    clear
    check-dns
    ;;
*)
    clear
    menu
    ;;
00)
    clear
    menu
    ;;
esac
 
