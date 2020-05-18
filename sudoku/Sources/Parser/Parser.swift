//
//  Parser.swift
//  sudoku
//
//  Created by Samuel Stuchly 18/05/2020.
//

import Foundation
import Board

/// Parser 
public struct Parser{

    /// accepted values into board
    private let acceptedValues = ["0","1","2","3","4","5","6", "7","8","9"]

    /// Initialize Parser
    public init(){}


    /// Parse string read from input file, representing entire board
    /// - Parameter content: read string from input file, to be parser 
    /// - Returns: Board filled with data from input file
    /// - Throws: string describing error
    public func parseInput(content:String) throws -> Board  {

        let rows = content.components(separatedBy:"\n")
        // remove whitespaces
        var myBoard = rows.map{ $0.replacingOccurrences(of: " ", with: "") }

        // check if file has correct format(has title)
        if myBoard[0] != "SUDOKU"{
            print("MISSING TITLE")
            throw "missing title"
        }

        // remove title
        myBoard.removeFirst()

        let lineSepArr = [0,4,8,12]

        //check if every line  with values read is 13 characters
        for (index,row) in myBoard.enumerated(){
            if !lineSepArr.contains(index){
                if !(row.count == 13){
                    throw "incorrect format"
                }
            }
        }

        for i in 0..<13{
            let currentRow = Array(myBoard[i])

            // check if file has correct format( has horizontal sepeareting lines)
            if lineSepArr.contains(i) {
                for j in currentRow{
                    if j != "-"{
                        throw "horizontal seperation not ok" 
                    }
                }
            }
            // check if file has correct format( has vertical sepeareting lines)
            else{
                for (index,value) in currentRow.enumerated(){
                    if lineSepArr.contains(index){
                        if value != "|"{
                            throw "vertical seperation not ok"
                        }
                    } 
                }
            }
        }

        var boardWithoutSeperators = [String]()

        // compose array without seperators
        for i in 0..<13{
            if lineSepArr.contains(i){
                continue
            } 
            else{
                boardWithoutSeperators.append(myBoard[i])
            }
        }

        // raw sudoku board
        var newBoard = Board(layout:[[Int]]())

        // fill the new raw board
        for i in boardWithoutSeperators{
            var row = Array(i)

            row.remove(at:0)
            row.remove(at:4 - 1)
            row.remove(at:8 - 2)
            row.remove(at:12 - 3)

            // check if row contains only accepted values
            for i in row {
                if !self.acceptedValues.contains(String(i)){
                    throw "incorrcet character"
                }
            }

            let intRow = row.map{ Int(String($0))! }

            newBoard.layout.append(intRow)
        }

        // board with loaded data
        return newBoard
    }
}

// so it is possible to throw a string
extension String: Error {}