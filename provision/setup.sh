#!/bin/bash

# fixes "stdin: is not a tty" error
sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

cat << EOF
====================
Scotch Box Multihost
====================
Updating packages
EOF

sudo su
sudo rm /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get -y update
sudo apt-get -y upgrade
# sudo apt-get -y install php7.0

# cat << EOF
# ====================
# Installing PHP7
# EOF
# 
# sudo apt-get -y install php7.0-mysql libapache2-mod-php7.0
# sudo a2dismod php5
# sudo a2enmod php7.0
# sudo apachectl restart
# 
# sudo apt-get -y install php-mbstring
# sudo service apache2 restart

cat << EOF
====================
Generating Locales
EOF

sudo locale-gen de_DE.UTF-8


cat << EOF
====================
Enabling Multihost
EOF

# Copy configuration files
cp /var/www/provision/multihost.conf /etc/apache2/sites-available
cp /var/www/provision/scotchbox.local.conf /etc/apache2/sites-available

a2enmod vhost_alias

a2ensite multihost
a2ensite scotchbox.local
a2dissite 000-default

service apache2 restart

cat << EOF
====================
Creating backup cron
To import latest dumps, use:
$ bash /var/www/provision/import-db.sh
EOF

echo "5 * * * * bash /var/www/provision/backup-db.sh > /dev/null" >> /etc/cron.d/backup-db

if [ $? -eq 0 ]; then
    echo "Yeah! So now we're ready to go!"
else
    echo "Ooops. Something went wrong here :/"
fi
