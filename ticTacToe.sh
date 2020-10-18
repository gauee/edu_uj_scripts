#!/bin/bash

LOG_DEBUG=1
ARRAY=( " " " " " " " " " " " " " " " " " ")

log_debug(){
if [ $LOG_DEBUG ];then
	echo "$(date) [DEBUG] $1"
fi
}

function calc_id {
echo "$(( $2*3-3+$1-1))"
}

function print_array {
for y in {1..3};do
	line=""
	for x in {1..3};do
		id=$(calc_id $x $y)
		line="$line|${ARRAY[$id]}"
	done
	echo "$line|"
done 
}

function set_value_at_array {
id="$(calc_id $1 $2)"
log_debug $id
ARRAY[$id]=$3
}

function validate_input {
id=$(calc_id $1 $2)
if [ ${ARRAY[$id]} = " " ];then
	echo "OK"
else
	echo "ERR"
fi
}

function read_input_from_player {
	read -p "Player $1: Provide x,y: " input
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
