#!/bin/bash

source ./start.sh
source ./spin.sh

bot_game() {
read -p "Do you have parameters saved(Yes/no)? " parsave
if [[ "$parsave" == "no" || "$parsave" == "n" || "$parsave" == "No" ]]; then
	setparameters	
else
	clear
	read -p "Please enter filename: " parfile
	
	while IFS= read -r line; do
		eval "$line"
	done < $parfile
fi
}

setparameters() {
clear
echo "Please set up your parameters:"
read -p "Minimum bet: " bet
read -p "Should the minimum bet be doubled on a loss? " doubleonloss
read -p "Total bankroll: " bankroll
read -p "Betting colour: " bcolor
read -p "Should the bot stop if bankroll reaches zero? " bankrollzero

}
