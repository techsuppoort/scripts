#!/bin/sh
#This script sets up the virtual serial console shell and moves files to the required locations

pkg install -y socat
mv ./serial-shell /usr/local/bin
mv ./virtual-serial-line.sh /root
chmod +x /usr/local/bin/serial-shell /root/virtual-serial-line.sh
echo /usr/local/bin/serial-shell >>/etc/shells
pw useradd -n serial-user -m -s /usr/local/bin/serial-shell
passwd serial-user

#uncomment if you want to automate via crontab
#echo '0 0 * * * root timeout 3590 /root/virtual-serial-line.sh >/dev/null 2>&1' >> /etc/crontab
