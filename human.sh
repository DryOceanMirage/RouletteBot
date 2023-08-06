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
echo "Bankroll: $hbankroll"
read -p "Place your bets (e.g., 'red 10', '28 25'): " hbet
read -p "Spinning the wheel... Press Enter"
spin_wheel
echo "--------------------------------------------------"
echo "The roulette wheel landed on: $number and $color"
echo "--------------------------------------------------"
# Separate player input into color and amount
read -a bet_arr <<< "$hbet"
bet_color="${bet_arr[0]}"
bet_amount="${bet_arr[1]}"

if [[ "$color" == "$bet_color" ]]; then
	hwin=$((hwin + 1))
	hmoneywon=$((hmoneywon + bet_amount))
	hbankroll=$((hbankroll + bet_amount))
	echo "Congratulations! You won $bet_amount"
else
	hloss=$((hloss + 1))
	hmoneyloss=$((hmoneyloss + bet_amount))
	hbankroll=$((hbankroll - bet_amount))
	echo "Sorry, you lost $bet_amount"
fi

read -p "Press Enter to play again or 'q' to quit: " play_again
if [[ "$play_again" != "q" ]]; then
	hplay
else
	save_game
	echo "Thanks for playing!"
	echo "Wins: $hwin, Losses: $hloss"
	echo "Total Money Won: $hmoneywon, Total Money Lost: $hmoneyloss"
fi
}
#saves the game
save_game() {
timestamp=$(date +%Y%m%d%H%M%S)
savefile="roulette_game_$timestamp.txt"

echo "Bankroll: $hbankroll" >> "$savefile"
echo "Wins: $hwin" >> "$savefile"
echo "Losses: $hloss" >> "$savefile"
echo "Total Money Won: $hmoneywon" >> "$savefile"
echo "Total Money Lost: $hmoneyloss" >> "$savefile"

echo "Game saved to: $savefile"
}
