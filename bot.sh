#!/bin/bash
bnumplay=0
bwin=0
bloss=0
bmoneywon=0
bmoneyloss=0

playbot() {
clear
spin_wheel
echo "Current balance: $bbankroll"
echo "$bbankroll" >> games/game$gnum.txt
echo "Playing game $bnumplay out of $btotalplay"
bnumplay=$((bnumplay+1))
if [[ "$color" == "$bcolor" ]]; then
        bwin=$((bwin + 1))
        bmoneywon=$((bmoneywon + bet_amount))
        bbankroll=$((bbankroll + bet_amount))
        lostlast=0
        lastbet=$bbet
        bet_amount=$bbet
        echo "win"
        checkgame
else
        bloss=$((bloss + 1))
        bmoneyloss=$((bmoneyloss + bet_amount))
        bbankroll=$((bbankroll - bet_amount))
        losslast=1
        lastbet=$bet_amount
        echo "loss"
        doubleloss
fi

}
#if there a savefile avalible
bot_game() {
read -p "Do you have parameters saved(Yes/no)? " parsave
if [[ "$parsave" == "no" || "$parsave" == "n" || "$parsave" == "No" ]]; then
	bnumplay=0
	bwin=0
	bloss=0
	bmoneywon=0
	bmoneyloss=0
	setparameters
else
	clear
	read -p "Please enter filename(Case sensitive): " parfile
	
	while IFS= read -r line; do
		eval "$line"
	done < $parfile
	read -p "Number of games that should be played: " btotalplay
	read -p "Enter game number: " gnum
	playbot
fi
}

setparameters() {
clear

echo "Please set up your parameters:"
read -p "Minimum bet: " bbet
read -p "Total bankroll: " bbankroll
read -p "Betting colour: " bcolor
read -p "Number of games that should be played: " btotalplay
read -p "Should the minimum bet be doubled on a loss(type 1 for yes on 0 for no)? " doubleonloss
read -p "Should the bot stop if bankroll reaches zero(type 1 for yes on 0 for no)? " bbankrollzero
read -p "Enter game number: " gnum

playbot
}

checkmoney() {
if [[ "$bbankrollzero" == "0" ]]; then
	playbot
elif [[ "$bbankroll" -lt "0" || "$bbankroll" != "0" && "$bbankroll"-"$bet_amount" < "0" ]]; then
	clear
	echo "Insufficient funds"
	bet_amount=0
	sleep 5
	summary
elif [[ "$bbankrollzero" == "1" ]]; then
	playbot
else
	echo "checkmoney error"
fi
}

checkgame() {
if [[ "$bnumplay" != "$btotalplay"  ]]; then
	checkmoney

else
	summary
fi
}

doubleloss() {
if [[ "$doubleonloss" == "1" ]]; then
	bet_amount=$((lastbet * 2))
	checkgame
else
	checkgame
fi
}


summary(){
clear
bwinper=$(( (bwin * 100) / bnumplay ))
echo "Current balance after $bnumplay games is $bbankroll."
echo "The total money that you won is $bmoneywon and the total lost is $bmoneyloss"
echo "You won $bwinper% of the time which is $bwin out of $bnumplay games"
read -p "Would you like to save the current simulation settings? " savebot
if [[ "$savebot" == "y" || "$savebot" == "yes" || "$savebot" == "y" ]]; then
	timestamp=$(date +%Y%m%d%H%M%S)
	savefile="roulette_simulation_$timestamp.txt"

	echo "bbet=$bbet" > "$savefile"
	echo "bbankroll=$bbankroll" >> "$savefile"
	echo "bcolor=$bcolor" >> "$savefile"
	echo "doubleonloss=$doubleonloss" >> "$savefile"
	echo "bbankrollzero=$bbankrollzero" >> "$savefile"

	echo "Game saved to: $savefile"
	read -p "Press enter to continue: "
	main_menu
else
	read -p "Press enter to continue: "
	main_menu
fi
}
