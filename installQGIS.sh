sudo su -

### Upgrade to 18.04 LTS Bionic ###
# install the update-manager-core package
sudo apt-get install update-manager-core

# Launch the upgrade tool
sudo do-release-upgrade -d


# Add resources from workshop repository
wget https://github.com/elpaso/qgis3-server-vagrant/archive/master.zip
unzip master.zip
rmdir /kiwashGIS/
mv qgis3-server-vagrant-master/ /kiwashGIS

# Add QGIS repositories
apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45
echo 'deb https://qgis.org/debian bionic main' > /etc/apt/sources.list.d/debian-gis.list
apt-get update && apt-get -y upgrade

# Available version of qgis-server >=3
apt-cache policy qgis-server

# Install QGIS including dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get -y install qgis-server python-qgis xvfb

# Confirm installation of qgis-server >=3
apt-cache policy qgis-server

# Install utilities (optional)
apt-get -y install vim unzip ipython3

# Confirm QGIS installed with no errors
/usr/lib/cgi-bin/qgis_mapserv.fcgi 2> /dev/null
<<RESULT
Content-Length: 54
Content-Type: text/xml; charset=utf-8
Server:  Qgis FCGI server - QGis version 3.0.0-Girona
Status:  500

<ServerException>Project file error</ServerException>
RESULT

# Install sample projects and plugins
export QGIS_SERVER_DIR=/home/qgis
cp -r /kiwashGIS/resources/web/htdocs $QGIS_SERVER_DIR
cp -r /kiwashGIS/resources/web/plugins $QGIS_SERVER_DIR
cp -r /kiwashGIS/resources/web/projects $QGIS_SERVER_DIR
chown -R www-data:www-data /home/qgis

# Install HTTP Server
apt-get install apache2 libapache2-mod-fcgid

# Create HTTP Server configuration file
#nano /etc/apache2/sites-available/qgis.demo.conf
cp /kiwashGIS/resources/apache2/001-qgis-server.conf /etc/apache2/sites-available

sed -i -e "s@QGIS_SERVER_DIR@${QGIS_SERVER_DIR}@g" /etc/apache2/sites-available/001-qgis-server.conf

sed -i -e 's/VirtualHost \*:80/VirtualHost \*:81/' /etc/apache2/sites-available/001-qgis-server.conf

sed -i -e "s@QGIS_SERVER_DIR@${QGIS_SERVER_DIR}@g" $QGIS_SERVER_DIR/htdocs/index.html

# Create QGIS Server log
mkdir /var/log/qgis/

# Configure permissions for Apache user www-data to access QGIS log files
chown www-data:www-data /var/log/qgis

# Create QGIS authentication database
mkdir /home/qgis/qgisserverdb

# Configure permissions for Apache user www-data to access QGIS authentication database
chown www-data:www-data /home/qgis/qgisserverdb

# Setup xvfb
cp /kiwashGIS/resources/xvfb/xvfb.service /etc/systemd/system/
# Create symlink
systemctl enable /etc/systemd/system/xvfb.service
# Start the service
service xvfb start

# Symlink to cgi for apache CGI mode
ln -s /usr/lib/cgi-bin/qgis_mapserv.fcgi /usr/lib/cgi-bin/qgis_mapserv.cgi

# Enable sites and restart
a2enmod rewrite # Only required by some plugins
a2enmod cgid # Required by plain old CGI
a2dissite 000-default
a2ensite 001-qgis-server

service apache2 restart # Restart the server

<<NOTES
Make sure that there is port alignment (80/81) across:
1. Network Security Group - INBOUND PORT RULES
2. /etc/apache2/ports.conf
3. /etc/apache2/sites-available/001-qgis-server.conf
NOTES