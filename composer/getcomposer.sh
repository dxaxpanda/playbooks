#!/bin/sh
whereis php
php -r "copy('https://getcomposer.org/installer', '/usr/local/bin/composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php /usr/local/bin/composer-setup.php --filename=composer
mv composer /usr/local/bin/composer
php -r "unlink('/usr/local/bin/composer-setup.php');"
