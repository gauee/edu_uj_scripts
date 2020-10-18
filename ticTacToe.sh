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


print_array
set_value_at_array 1 1 'X'
print_array
set_value_at_array 2 1 'O'
print_array
