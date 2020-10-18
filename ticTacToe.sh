#!/bin/bash

ARRAY=( " " " " " " " " " " " " " " " " " ")

function print_array {
for x in {0..2};do
	idx=$(expr $x*3+y)
	echo "|${ARRAY[$idx]}|${ARRAY[$idx+1]}|${ARRAY[$idx+2]}|"
done 
}


print_array
