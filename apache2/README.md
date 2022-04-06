# Matomo on Apache2

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

Installing Apache2 and necessary tools

```
sudo apt install nginx wget unzip -y
```

Installing PHP, Libraries and MySQL

```
sudo apt install php php-curl php-gd php-cli mysql-server php-mysql php-xml php-mbstring -y
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

## Reload Apache

```
sudo systemctl reload apache2
```

## Done!

Matomo is now available at http://mydomain.com/matomo