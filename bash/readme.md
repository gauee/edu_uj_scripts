### The 'ticTacToe.sh' script implements the simple TicTacToe game.
It is written in bash.
To play game please execute:
```shell
./ticTacToe.sh
```

To enable/disabled clearing the screen
```shell
#to active
export ACTIVE_CLEAR=1

#to disable
unset ACTIVE_CLEAR 
```

To enable/disabled debug logging
```shell
#to active
export LOG_DEBUG=1

#to disable
unset LOG_DEBUG
``` 

Example game output
```
./ticTacToe.sh 
Welcome in TicTacToe
 |x	|1|2|3|
y| 
1	| | | |
2	| | | |
3	| | | |
Player X: Provide x,y: 1,1

 |x	|1|2|3|
y| 
1	|X| | |
2	| | | |
3	| | | |
Player O: Provide x,y: 2,2

 |x	|1|2|3|
y| 
1	|X| | |
2	| |O| |
3	| | | |
Player X: Provide x,y: 3,3

 |x	|1|2|3|
y| 
1	|X| | |
2	| |O| |
3	| | |X|
Player O: Provide x,y: 1,3

 |x	|1|2|3|
y| 
1	|X| | |
2	| |O| |
3	|O| |X|
Player X: Provide x,y: 3,1

 |x	|1|2|3|
y| 
1	|X| |X|
2	| |O| |
3	|O| |X|
Player O: Provide x,y: 2,1

 |x	|1|2|3|
y| 
1	|X|O|X|
2	| |O| |
3	|O| |X|
Player X: Provide x,y: 3,2

 |x	|1|2|3|
y| 
1	|X|O|X|
2	| |O|X|
3	|O| |X|
Player X: Won the game

```

#### TODOs:
* ~~Improve the user input validation~~
