#!/bin/bash
bnumplay=0
bwin=0
bloss=0
bmoneywon=0
bmoneyloss=0

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
	playbot
fi
}

setparameters() {
clear

echo "Please set up your parameters:"
read -p "Minimum bet: " bbet
read -p "Should the minimum bet be doubled on a loss(type 1 for yes on 0 for no)? " doubleonloss
read -p "Total bankroll: " bbankroll
read -p "Betting colour: " bcolor
read -p "Should the bot stop if bankroll reaches zero(type 1 for yes on 0 for no)? " bbankrollzero
read -p "Number of games that should be played: " btotalplay

playbot
}

playbot() {
clear
spin_wheel
echo "Current balance: $bbankroll"
echo "Playing game $bnumplay out of $btotalplay"
bnumplay=$((bnumplay+1))
if [[ "$color" == "$bcolor" ]]; then
        bwin=$((bwin + 1))
        bmoneywon=$((bmoneywon + bet_amount))
        bbankroll=$((bbankroll + bet_amount))
        lostlast=0
        lastbet=$bbet
        bet_amount=$bbet
        echo "Congratulations! You won $bet_amount"
else
        bloss=$((bloss + 1))
        bmoneyloss=$((bmoneyloss + bet_amount))
        bbankroll=$((bbankroll - bet_amount))
        losslast=1
        echo "Sorry, you lost $bet_amount"
        doubleloss
fi

}
checkmoney() {

}

doubleloss() {
if [[ "doubleonloss" == "1" ]]; then
	bet_amount=$(($lastbet*2))
	checkgame
else
	checkgame
fi
}

checkgame() {
if [[ "$bnumplay" != "$btotalplay" && "$bbankroll" -gt "0" || "$bbankroll" != "0"  ]]; then
	playbot

else
	summary
fi
}



summary(){
clear
echo "Current balance after $btotalplay games is $bbankroll."
echo "The total money that you won is $bmoneywon and the total lost is $bmoneyloss"
read "Press enter to continue: "
}
