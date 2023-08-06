#!/bin/bash


human_game() {
read -p "Would you like to open a saved game(Yes/no)? " savegame

if [[ "$savegame" == "no" || "$savegame" == "n" ]]; then
	clear
	new_human_game
	
else
	clear
	read -p "Please enter savename(Case sensitive): " savefile
	while IFS= read -r line; do
		eval "$line"
	done < $savegame
fi
}
#Creates a new game
new_human_game() {
clear
echo "Welcome to the game of roulette"
read -p "Please enter starting bankroll: " hbankroll
hwin=0
hloss=0
hmoneywon=0
hmoneyloss=0
hplay
}

hplay() {
clear
read -p "Place your bets: " hbet
}
