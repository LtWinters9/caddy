#!/bin/bash

set -e

# -------------------------------------------
# Ensure we are running the installer as root
# -------------------------------------------
if [[ $EUID -ne 0 ]]; then
  echo "  Aborting because you are not root" ; exit 1
fi

function start_install {
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
}

function start_setup {
sudo apt update -y
sudo apt install caddy -y
}

function end_script {
echo "Installed Caddy on ${HOSTNAME}"
cd /var/
mkdir www
cd #
sudo chmod -R 775 /var/www/
sudo chown -R www-data:www-data /var/www/
exit 1
}

### Start Script
echo "Script now running!"
start_install && sleep 1 && clear
start_setup && sleep 1 && clear
end_script
