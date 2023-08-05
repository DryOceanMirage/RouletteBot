#!/bin/bash

#Source for the functions
source ./human.sh
source ./bot.sh
source ./spin.sh
main_menu() {
	read -p "Would you like to run a sumulation? " hubot

	if [[ "$hubot" == "n" || "$hubot" == "no" ]]; then
		human_game
		
	else
		bot_game
	fi
done
}
