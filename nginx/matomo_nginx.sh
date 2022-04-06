web_path=/var/www/html

sudo apt update -y && sudo apt upgrade -y
sudo apt install nginx wget unzip -y
sudo apt install php php-curl php-gd php-cli mysql-server php-mysql php-xml php-mbstring php-fpm -y

sudo wget https://builds.matomo.org/matomo.zip -O matomo.zip && sudo unzip -q matomo.zip -d $web_path/ -x 'How to install Matomo.html'
sudo rm matomo.zip
sudo chown www-data:www-data $web_path/matomo/ -R

sudo systemctl reload nginx

phpsock=$(find /var/run/php/ -name "php[0-9]*.sock")

echo "
ATENTION!!!
Please, insert this location block into your NGINX config (by default it is /etc/nginx/sites-available/default)...

location ~ \.php$ {
  include snippets/fastcgi-php.conf;
  fastcgi_pass unix:$phpsock;
}

Also make sure there is an index.php file in the index directive.

And then reload nginx (sudo systemctl reload nginx)
"