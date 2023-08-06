#!/bin/bash

#Source for the functions
source ./spin.sh
source ./human.sh
source ./bot.sh

#menuchoices
main_menu() {
	echo "Type 'justSpin' to start spinning without betting."
	echo "Enter q to quit the game."
	read -p "Would you like to run a sumulation? " hubot

	if [[ "$hubot" == "n" || "$hubot" == "no" ]]; then
		human_game
		
	elif [[ "$hubot" == "justSpin" || "$hubot" == "justspin" || "$hubot" == "Justspin" ]]; then
		spin_out
	elif [[ "$hubot" == "q" || "$hubot" == "quit" || "$hubot" == "exit" ]]; then
		clear
		echo "Thanks for playing"
		sleep 1
		clear
		exit 0
		
	elif [[ "$hubot" == "y" || "$hubot" == "yes" ]]; then
		bot_game
	else
		clear
		echo "-----------------------------------"
		echo "Invalid responce please type:"
		echo "yes for a simulation"
		echo "no for a game where you play"
		echo "justSpin to play without betting"
		echo "Enter q to quit the game"
		echo "-----------------------------------"
		sleep 2
		main_menu
	fi
}

main_menu
