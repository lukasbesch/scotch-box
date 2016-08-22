# fixes "stdin: is not a tty" error
sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

# Copy configuration files
cp /var/www/provision/multihost.conf /etc/apache2/sites-available
cp /var/www/provision/scotchbox.local.conf /etc/apache2/sites-available

a2enmod vhost_alias

a2ensite multihost
a2ensite scotchbox.local
a2dissite 000-default

service apache2 restart

echo "5 * * * * bash /var/www/provision/backup-db.sh > /dev/null" >> /etc/cron.d/backup-db

if [ $? -eq 0 ]; then
    echo "Yeah! So now we're ready to go!"
else
    echo "Ooops. Something went wrong here :/"
fi
