#!/bin/bash

#is there a savefile avalible
bot_game() {
read -p "Do you have parameters saved(Yes/no)? " parsave
if [[ "$parsave" == "no" || "$parsave" == "n" || "$parsave" == "No" ]]; then
	setparameters	
else
	clear
	read -p "Please enter filename(Case sensitive): " parfile
	
	while IFS= read -r line; do
		eval "$line"
	done < $parfile
fi
}

setparameters() {
clear
echo "Please set up your parameters:"
read -p "Minimum bet: " bbet
read -p "Should the minimum bet be doubled on a loss? " doubleonloss
read -p "Total bankroll: " bbankroll
read -p "Betting colour: " bcolor
read -p "Should the bot stop if bankroll reaches zero? " bbankrollzero
read -p "Number of games that should be played: " bnumplay
playbot
}

playbot() {

}

