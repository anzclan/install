# XRAY MULTI PORT

# INSTALL
```html
apt update && apt upgrade -y && update-grub && sleep 2 && apt-get update -y && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/anzclan/install/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
```
