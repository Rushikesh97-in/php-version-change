#!/bin/bash

clear

printf "\n"
php -v
printf "\n\n"

Danger='\033[0;31m'  # Red Color
Success='\033[0;32m' # Green Color
Warning='\033[1;33m' # Yellow Color
NC='\033[0m'         # No Color

printf "PHP versions:\n"
update-alternatives --list php

php=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

printf "\n"
read -p "PHP version you wont? (n for exit): " answer

if [[ "$answer" == [n] ]]; then
	clear
	printf "${Warning} EXIT: nothing changed. ${NC} \n\n"
	exit
elif (($(echo "$answer == $php" | bc -l))); then
	clear
	printf "${Warning} EXIT: no change needed. ${NC} \n\n"
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
	printf "${Warning} EXIT: nothing changed. ${NC} \n\n"
	exit
fi

echo "$answer" | sudo update-alternatives --config php

# sudo update-alternatives --config php;

sudo service apache2 restart

clear

printf "${Success} DONE: php version has been changed. ${NC} \n\n\n"

php -v
printf "\n"
