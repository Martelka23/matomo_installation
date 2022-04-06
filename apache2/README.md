# Matomo на Apache2

## Подготовка

Создадим переменную, в которую запишем путь к папке, в которую хотим поставить Matomo

```
web_path=/var/www/html
```

Обновление пакетного менеджера

```
sudo apt update -y && sudo apt upgrade -y
```

## Установка инструментов

Установка Apache2 и необходимых инструментов

```
sudo apt install apache2 wget unzip -y
```

Установка PHP, библиотек и MySQL

```
sudo apt install php php-curl php-gd php-cli mysql-server php-mysql php-xml php-mbstring php-fpm -y
```

## Установка матомо

Скачиваем и разархивируем Matomo

```
sudo wget https://builds.matomo.org/matomo.zip -O matomo.zip && sudo unzip -q matomo.zip -d $web_path/ -x 'How to install Matomo.html'
sudo rm matomo.zip
```

Меняем владельца папки с Matomo

```
sudo chown www-data:www-data $web_path/matomo/ -R
```

## Перезагрузим Apache

```
sudo systemctl reload apache2
```

## Готово!

Теперь Matomo доступен по адресу http://mydomain.com/matomo