#!/bin/sh
#run this as root
apt install -y nginx fcgiwrap jq
systemctl enable --now fcgiwrap.service
mv ./api /etc/nginx/sites-available/
mkdir -p /srv/script/auth
chown -r www-data:www-data /srv/script
mv ./add_user.sh ./login.sh ./users.sh /srv/script
ln -s /etc/nginx/sites-enabled/api /etc/nginx/sites-available/api
chmod +x /srv/script/*
systemctl restart nginx
