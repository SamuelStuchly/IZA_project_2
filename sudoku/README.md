# Sudoku Solver/Validator

- Author : Samuel Stuchly
- Login : xstuch06
----
## Functionality 

Application takes in file with sudoku and attempts so solve it. Apllication checks if input sudoku is correct format, follows the rules of Sudoku, and then a backtracking algorithm is used to find out if sudoku is solvable or not. 
Application will either print out solved sudoku, or inform user that sudoku was either invalid or unsolvable.

## Usability 
This application can be used for getting a solution to a difficult sudoku puzzle you were having trouble with. 
Or with a use of `--validate-only` option, it can be used just as a validator, to check if part of your solution is on the right track, or you have already made a mistake somewhere and did not realize.

## Format of Sudoku file
This application works with input files of specified format. Example file is here `sudoku_input_files/valid_sudoku.txt`.

Sudoku file needs to have a title that says `SUDOKU` on the first line, and then a sudoku board of following format.
```
        SUDOKU
-------------------------
| 0 0 0 | 0 0 0 | 0 0 0 | 
| 0 0 0 | 0 0 0 | 0 0 0 |
| 0 0 0 | 0 0 0 | 0 0 0 | 
-------------------------
| 0 0 0 | 0 0 0 | 0 0 0 | 
| 0 0 0 | 0 0 0 | 0 0 0 | 
| 0 0 0 | 0 0 0 | 0 0 0 | 
-------------------------
| 0 0 0 | 0 0 0 | 0 0 0 | 
| 0 0 0 | 0 0 0 | 0 0 0 | 
| 0 0 0 | 0 0 0 | 0 0 0 | 
-------------------------
```
Zeros in sudoku file mean the value is not set.

To make your own sudoku file, copy this format and input your values.



## Usage 

To run this aplication, navigate to `sudoku` directory and type run command :
```
swift run sudoku <input-file-path> [--validate-only]
```
The `--validate-only` option is set if you dont wish to see solved sudoku, only to display whether your input sudoku is on the right track or is, as input, unsolvable.

In directory `sudoku_input_files` there are examples of sudokus having different kinds of issue and one valid. To see program work without your own data run :
```
swift run sudoku sudoku_input_files/valid_sudoku.txt
```
----
