#!/bin/bash

#LOG_DEBUG=1
#ACTIVE_CLEAR=1
ARRAY=( " " " " " " " " " " " " " " " " " ")

log_debug(){
if [ $LOG_DEBUG ];then
	echo "$(date) [DEBUG] $1"
fi
}

function calc_id {
echo "$(( $1*3-3+$2-1))"
}

function get_col_str {
id=$(calc_id $1 1)
echo "${ARRAY[$id]}${ARRAY[$id+1]}${ARRAY[$id+2]}"
}

function get_row_str {
id=$(calc_id 1 $1)
echo "${ARRAY[$id]}${ARRAY[${id}+3]}${ARRAY[${id}+6]}"
}

function get_diag_down {
echo "${ARRAY[0]}${ARRAY[4]}${ARRAY[8]}"
}

function get_diag_up {
echo "${ARRAY[6]}${ARRAY[4]}${ARRAY[2]}"
}

function print_array {
if [ $ACTIVE_CLEAR ];then
	clear
fi
echo -e " |x\t|1|2|3|"
echo -e "y| "
for y in {1..3};do
	line="$y\t"
	for x in {1..3};do
		id=$(calc_id $x $y)
		line="$line|${ARRAY[$id]}"
	done
	echo -e "$line|"
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

function check_winner {
expected="$1$1$1"
log_debug "Expecting: $expected"
for i in {1..3};do
	log_debug "Row $i: $(get_row_str $i)"
	log_debug "Col $i: $(get_col_str $i)"
	if [ "$expected" = "$(get_row_str $i)" ] || [ "$expected" = "$(get_col_str $i)" ];then
		echo "Player $1: Won the game"
		exit 0
	fi
done
log_debug "Dial up: $(get_diag_up)"
log_debug "Dial_down: $(get_diag_down)"
if [ "$expected" = "$(get_diag_up)" ] || [ "$expected" = "$(get_diag_down)" ];then
        echo "Player $1: Won the game"
	exit 0
fi
}

function read_input {
is_valid="NO"
read -p "Player $1: Provide x,y: " input
log_debug "Read input: '$input'"
if ! [[ "$input" =~ [1-3],[1-3] ]]; then
	is_valid="Invalid '[1-3],[1-3]' pattern"
else
	IFS=",";read -a inputs <<< "$input"
	printf "\n"
	is_valid=$(validate_input ${inputs[0]} ${inputs[1]})
fi
while [ "OK" != "$is_valid" ];do
        echo "[$is_valid] Your input ($input) was incorrect, please review the current array state and update your input"
	read_input
done
}

function process_game_step {
	read_input $1
	set_value_at_array ${inputs[0]} ${inputs[1]} $1
        print_array
	check_winner $1
}


echo "Welcome in TicTacToe"
print_array
for step in X O X O X O X O X;do
	log_debug "step $step"
	process_game_step $step
done
echo "DRAW: nobody won"
exit 0
