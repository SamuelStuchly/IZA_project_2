//
//  Solver.swift
//  sudoku
//
//  Created by Samuel Stuchly 18/05/2020.
//

import Board

/// Solver
public struct Solver {
    /// Board holding sudoku that will be solved
    public var board : Board

    /// Initialize Solver with given Board
    /// - Parameter board: sudoku board
    public init(board: Board) {
        self.board = board
    }

    
    /// Find first empty spot on the board
    /// - Returns: Tuple with row and column of found empty spot on the board
     private func getFirstEmptySpot() -> (column:Int,row:Int){
        for (i,row) in self.board.layout.enumerated(){
            for (j,column) in row.enumerated(){
                if column == 0 {
                    return (j,i) // j = column, i = row            
                }
            }
        }
        return (-1,-1)
    }


    /// Check if inputing value on specified spot on the sudoku board is a valid move
    /// - Parameter number: input value
    /// - Parameter position: Tuple representing position of input value
    /// - Returns: true if the input is valid, false if not
    private func isValid(number:Int,position:(column:Int,row:Int)) -> Bool {

        // check for conflicting values in a row
        for i in 0..<self.board.layout[position.row].count{
            if self.board.layout[position.row][i] == number && position.column != i{
                return false
            }
        }

        // check for conflicting values in a column
        for i in 0..<self.board.layout.count{
            if self.board.layout[i][position.column] == number && position.row != i{
                return false
            }
        }

        // check for conflicting values in a box
        let box_x = Int(position.column / 3)
        let box_y = Int(position.row / 3)

        for i in (box_y*3)..<(box_y * 3 + 3){
            for j in (box_x*3)..<(box_x * 3 + 3){
                if self.board.layout[i][j] == number && (i,j) != position{
                    return false
                }
            }
        }
        // no conflicting values found anywhere
        return true
    }


    /// Solves sudoku, uses backtracking algorithm
    /// - Returns: true if sudoku is solvable, false if unsolvable
    public mutating func solve()-> Bool{
        let foundSpot = getFirstEmptySpot()
        if foundSpot == (-1,-1){
            return true
        }
        
        let row = foundSpot.row
        let column = foundSpot.column
        
        // loop through every value for given spot until it is valid value
        for i in 1...9{
            if isValid(number:i,position:(column:column,row:row)){
                self.board.layout[row][column] = i
                
                // recursive call of solve()
                if solve(){
                    return true
                }
                else{
                    // backtrack 
                    self.board.layout[row][column] = 0
                }
            }
        }
        // algorithm ends without solving the board
        return false
    }


}