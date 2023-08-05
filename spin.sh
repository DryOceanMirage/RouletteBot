#!/bin/bash

# Array of roulette wheel numbers with their colors
roulette_numbers=("0" "28" "9" "26" "30" "11" "7" "20" "32" "17" "5" "22" "34" "15" "3" "24" "36" "13" "1" "00" "27" "10" "25" "29" "12" "8" "19" "31" "18" "6" "21" "33" "16" "4" "23" "35" "14" "2")

# Function to simulate a spin of the roulette wheel
spin_wheel() {
    random_index=$(( RANDOM % ${#roulette_numbers[@]} ))
    number="${roulette_numbers[$random_index]}"
    
    if [[ "$number" == "0" || "$number" == "00" ]]; then
        color="green"
    elif (( $number % 2 == 0 )); then
        color="black"
    else
        color="red"
    fi
}

# Main
spin_out() {
clear
echo "Welcome to the Roulette Wheel Spin!"
echo "Press Enter to spin the wheel..."
read

spin_wheel

echo "The roulette wheel landed on: $number and $color"
read
spin_out
}
