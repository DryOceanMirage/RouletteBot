#!/bin/bash

source ./start.sh
source ./spin.sh

read -p "Would you like to open a saved game(Yes/no)? " savegame

if [[ "$savegame" == "no" || "$savegame" == "n" ]]; then
	clear
	
else
	clear
	read -p "Please enter savename: " savefile
	while IFS= read -r line; do
		eval "$line"
	done < $savegame
fi

