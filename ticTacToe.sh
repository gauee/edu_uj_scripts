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

echo "Welcome in TicTacToe"
while true;do
	print_array
	echo "[X] Player #1: Provide input"
	read input_1
	set_value_at_array $(echo $input_1 | awk '{print $1}') $(echo $input_1 | awk '{print $2}') X
	print_array
	echo "[O] Player #2: Provide input"
	read input_2
	set_value_at_array $(echo $input_2 | awk '{print $1}') $(echo $input_2 | awk '{print $2}') O
	print_array
done
