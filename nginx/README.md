# Matomo на NGINX

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

Установка NGINX и необходимых инструментов

```
sudo apt install nginx wget unzip -y
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

## Настройка NGINX

Найдем полный путь к php-fpm файлу и запомним его

```
find /var/run/php/ -name "php[0-9]*.sock"
```

Открываем конфиг NGINX (по стандарту это файл /etc/nginx/sites-available/default)

```
nano /etc/nginx/sites-available/default
```

Добавляем дополнительный блок location внутри блока server. В fastcgi_pass нужно вставить путь к файлу php-fpm, который мы нашли

```
location ~ \.php$ {
  include snippets/fastcgi-php.conf;
  fastcgi_pass unix:<ПУТЬ К PHP FPM>;
}
```

Добавляем index.php файл в директиву index

```
index index.html index.php index.nginx-debian.html;
```

Сохраняем изменения и перезапускаем NGINX

```
sudo systemctl reload nginx
```

## Готово!

Теперь Matomo доступен по адресу http://mydomain.com/matomo