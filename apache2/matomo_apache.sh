web_path=/var/www/html

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y php php-curl php-gd php-cli mysql-server php-mysql php-xml php-mbstring
sudo apt install -y apache2 wget unzip

sudo wget https://builds.matomo.org/matomo.zip -O matomo.zip && sudo unzip -q matomo.zip -d $web_path/ -x 'How to install Matomo.html'
sudo rm matomo.zip

sudo chown www-data:www-data $web_path/matomo/ -R

sudo systemctl reload apache2
