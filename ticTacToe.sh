#!/bin/bash

LOG_DEBUG=1
ARRAY=( " " " " " " " " " " " " " " " " " ")

log_debug(){
if [ $LOG_DEBUG ];then
	echo "$(date) [DEBUG] $1"
fi
}

function print_array {
for x in {0..2};do
	idx="$(( $x*3 ))"
	echo "|${ARRAY[$idx]}|${ARRAY[$idx+1]}|${ARRAY[$idx+2]}|"
done 
}

function set_value_at_array {
idx=$1
idy=$2
value=$3
id="$(( $idy*3-3+$idx ))"
log_debug $id
ARRAY[$id]=$value
}

function validate_input {
id="$(( $1*3-3+$2 ))"
if [ ${ARRAY[$id]} = " " ];then
	echo "OK"
else
	echo "ERR"
fi
}

function read_input_from_player {
	echo "Player $1"
	read -p "Provide x,y: " input
	IFS=",";read -a inputs <<< "$input"
	printf "\n"
	is_valid=$(validate_input ${inputs[0]} ${inputs[1]})
	while [ "OK" != "$is_valid" ];do
		echo "Your input was incorrect ($input), please review the current array state and update your input"
		read -p "Provide x,y: " input
        	IFS=",";read -a inputs <<< "$input"
        	printf "\n"
        	is_valid=$(validate_input ${inputs[0]} ${inputs[1]})
	done
	set_value_at_array ${inputs[0]} ${inputs[1]} $1
        print_array
}
	

echo "Welcome in TicTacToe"
while true;do
	read_input_from_player 'X'
	read_input_from_player 'O'
done
