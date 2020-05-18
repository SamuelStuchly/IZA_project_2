//
//  Board.swift
//  sudoku
//
//  Created by Samuel Stuchly 18/05/2020.
//

/// Sudoku Board
public struct Board{
    /// layout of sudoku board
    public var layout : [[Int]]
   

    /// Initialize Board with given layout
    /// - Parameter layout: data for a board
    public init(layout: [[Int]]){
        self.layout = layout
    }

    // Check if loaded board form input file is a valid sudoku board 
    /// - Returns: true if it is valid sudoku board, false if not
    public func isValidInput() -> Bool {

        

        // check if values in rows follow sudoku rules
        for i in 0..<9{
            var valuesList = [Int]()
            for j in 0..<9{
                if self.layout[i][j] != 0 && valuesList.contains(self.layout[i][j]){
                    return false
                }
                valuesList.append(self.layout[i][j])
            }
        }

        // check if values in columns follow sudoku rules
        for i in 0..<9{
            var valuesList = [Int]()
            for j in 0..<9{
                if self.layout[j][i] != 0 && valuesList.contains(self.layout[j][i]){
                    return false
                }
                valuesList.append(self.layout[j][i])
            }
        }

        // check if values in boxes follow sudoku rules
        for i in 0..<3{
            for j in 0..<3{
                let box_x = i
                let box_y = j

                var valuesList = [Int]()
                for i in (box_y*3)..<(box_y * 3 + 3){
                    for j in (box_x*3)..<(box_x * 3 + 3){
                        if self.layout[i][j] != 0 && valuesList.contains(self.layout[i][j]){
                            return false
                        }
                        valuesList.append(self.layout[i][j])
                    }
                }
            }
        }
        // no conflict of vlaues with sudoku rules found
        return true
    }


    /// Prints out board in a nice format
    /// - Parameter title: specificatons before the board is printed
    public func printBoard(title:String){
        print(" " + title + " :")
        var rowCount = 0
        print("-------------------------")
        for row in self.layout{
            var columnCount = 0
            print("|", terminator:" ")
            for value in row {
                print(value, terminator:" ")
                columnCount+=1
                if columnCount % 3 == 0 {
                    print("|", terminator:" ")
                }
            }
            print("")
            rowCount += 1
            if rowCount % 3 == 0 {
                    print("-------------------------")
                }

        }
    }

    /// Prints out pretty arrow :) 
    public func printArrow(){
        print("             ||")
        print("             ||")
        print("            \\  /")
        print("             \\/")
    }
}