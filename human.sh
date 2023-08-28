#!/bin/bash


human_game() {
read -p "Would you like to open a saved game(Yes/no)? " savegame

if [[ "$savegame" == "no" || "$savegame" == "n" ]]; then
	clear
	new_human_game
	
else
	clear
	savegame=1
	read -p "Please enter savename(Case sensitive): " savefile
	while IFS= read -r line; do
		eval "$line"
	done < $savefile
	hplay
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
read -p "Place your bets (e.g. colour or number): " hbet
read -p "Enter amount you want to bet: " bet_amount
hbankplusbet=$((hbankroll+bet_amount))
# check if money exists to bet
checkhmoney
read -p "Spinning the wheel... Press Enter"
spin_wheel
echo "--------------------------------------------------"
echo "The roulette wheel landed on: $number and $color"
echo "--------------------------------------------------"
# Separate player input into color and amount
if [[ "$hbet" == "red" || "$hbet" == "Red" || "$hbet" == "Black" || "$hbet" == "black" || "$hbet" == "Green" || "$hbet" == "green" ]]; then
    if [[ "$color" == "$hbet" ]]; then
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
fi

if [[ "$hbet" != "red" && "$hbet" != "Red" && "$hbet" != "Black" && "$hbet" != "black" && "$hbet" != "Green" && "$hbet" != "green" ]]; then
    if [[ "$number" == "$hbet" ]]; then
        hwin=$((hwin + 1))
        hmoneywon=$((hmoneywon + bet_amount * 35))
        hbankroll=$((hbankroll + bet_amount * 35))
        totalwin=$((bet_amount * 35))
        echo "Congratulations! You won $totalwin"
    else
        hloss=$((hloss + 1))
        hmoneyloss=$((hmoneyloss + bet_amount))
        hbankroll=$((hbankroll - bet_amount))
        echo "Sorry, you lost $bet_amount"
    fi

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
checkhmoney(){
if [[ "$hbankplusbet" -lt 0 ]]; then
	echo "Not enough money"
	sleep 3
	hplay
else
	
fi
}
#saves the game
save_game() {
if [[ "$savegame" == 1 ]]; then
	echo "hbankroll=$hbankroll" > "$savefile"
	echo "hwins=$hwin" >> "$savefile"
	echo "hloss=$hloss" >> "$savefile"
	echo "hmoneywon=$hmoneywon" >> "$savefile"
	echo "hmoneyloss=$hmoneyloss" >> "$savefile"
	sleep 3
	main_menu
else
	timestamp=$(date +%Y%m%d%H%M%S)
	savefile="roulette_game_$timestamp.txt"

	echo "hbankroll=$hbankroll" > "$savefile"
	echo "hwins=$hwin" >> "$savefile"
	echo "hloss=$hloss" >> "$savefile"
	echo "hmoneywon=$hmoneywon" >> "$savefile"
	echo "hmoneyloss=$hmoneyloss" >> "$savefile"

	echo "Game saved to: $savefile"
	sleep 3
	main_menu
fi
}
