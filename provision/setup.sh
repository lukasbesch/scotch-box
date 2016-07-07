# fixes "stdin: is not a tty" error
sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

# Copy configuration files
cp /var/www/provision/multihost.conf /etc/apache2/sites-available

a2enmod vhost_alias > /dev/null

a2ensite multihost.conf > /dev/null
a2dissite 000-default.conf > /dev/null
a2dissite scotchbox.local.conf > /dev/null

service apache2 restart > /dev/null

echo "5 * * * * bash /var/www/provision/backup-db.sh > /dev/null" >> /etc/cron.d/backup-db

if [ $? -eq 0 ]; then
    echo "Yeah! So now we're ready to go!"
else
    echo "Ooops. Something went wrong here :/"
fi