# Matomo on NGINX

## Preparation

Let's create a variable in which we will write the path to the folder where we want to put Matomo

```
web_path=/var/www/html
```

Package manager update

```
sudo apt update -y && sudo apt upgrade -y
```

## Installing tools

Installing NGINX and necessary tools

```
sudo apt install nginx wget unzip -y
```

Installing PHP, Libraries and MySQL

```
sudo apt install php php-curl php-gd php-cli mysql-server php-mysql php-xml php-mbstring php-fpm -y
```

## Matomo installation

Download and unzip Matomo

```
sudo wget https://builds.matomo.org/matomo.zip -O matomo.zip && sudo unzip -q matomo.zip -d $web_path/ -x 'How to install Matomo.html'
sudo rm matomo.zip
```

Change folder's owner

```
sudo chown www-data:www-data $web_path/matomo/ -R
```

## Setting up NGINX

Find the full path to the php-fpm file and remember it

```
find /var/run/php/ -name "php[0-9]*.sock"
```

Open NGINX config (by default it is /etc/nginx/sites-available/default)

```
nano /etc/nginx/sites-available/default
```

Add an additional location block inside the server block. In fastcgi_pass you need to insert the path to the php-fpm file that we found earlier

```
location ~ \.php$ {
  include snippets/fastcgi-php.conf;
  fastcgi_pass unix:<PHP FPM PATH>;
}
```

Add an index.php file to the index directive

```
index index.html index.php index.nginx-debian.html;
```

Save changes and reload NGINX

```
sudo systemctl reload nginx
```

## Done!

Matomo is now available at http://mydomain.com/matomo
