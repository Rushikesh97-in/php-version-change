#!/bin/bash

clear

printf "\n"
php -v
printf "\n\n"

printf "PHP versions:\n"
update-alternatives --list php

php=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

printf "\n"
read -p "PHP version you wont? (n for exit): " answer

if [[ "$answer" == [n] ]]; then
	clear
	printf "EXIT: nothing changed. \n\n"
	exit
elif (($(echo "$answer == $php" | bc -l))); then
	clear
	printf "EXIT: no change needed. \n\n"
	exit
fi

echo [PASSW0RD] | sudo -S echo -n 2>/dev/random 1>/dev/random
sudo a2dismod "php$php"

printf "\n"
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
	printf "EXIT: nothing changed. \n\n"
	exit
fi

echo "$answer" | sudo update-alternatives --config php

# sudo update-alternatives --config php;

sudo service apache2 restart

clear

printf "DONE: php version has been changed! \n\n\n"

php -v
printf "\n"
