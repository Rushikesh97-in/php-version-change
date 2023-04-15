#!/bin/bash

clear

echo ""
php -v
echo ""
echo ""

echo "PHP versions:"
update-alternatives --list php

php=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

echo ""
read -p "PHP version you wont? (n for exit): " answer

if [[ "$answer" == [n] ]]; then
	clear
	echo "EXIT: nothing changed. "
	echo ""
	exit
elif (($(echo "$answer == $php" | bc -l))); then
	clear
	echo "EXIT: no change needed. "
	echo ""
	exit
fi

echo [PASSWORD] | sudo -S echo -n 2>/dev/random 1>/dev/random
sudo a2dismod "php$php"

echo ""
sudo a2enmod php$answer

if (($(echo "$answer == 7.0" | bc -l))); then
	answer=1
elif (($(echo "$answer == 7.3" | bc -l))); then
	answer=2
elif (($(echo "$answer == 7.4" | bc -l))); then
	answer=3
elif (($(echo "$answer == 8.1" | bc -l))); then
	answer=4
elif (($(echo "$answer == 8.2" | bc -l))); then
	answer=5
else
	clear
	echo "EXIT: nothing changed. "
	echo ""
	exit
fi

echo "$answer" | sudo update-alternatives --config php

# sudo update-alternatives --config php;

sudo service apache2 restart

clear

echo "DONE: php version has been changed!"
echo ""
echo ""

php -v
echo ""
