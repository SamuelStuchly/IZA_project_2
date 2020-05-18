//
//  main.swift
//  sudoku
//
//  Created by Samuel Stuchly 18/05/2020.
//

import Foundation
import Board
import Parser
import Solver

/// Main 
func main() -> Result<Void, RunError> {
    
    /// flag to set output to to validate only 
    let validateOnly : Bool

    /// path to input file
    let path : String

    // -- Parse arguments -- //
    let args = CommandLine.arguments
    if args.count != 2 {
        if args.count != 3{
            print("USAGE: sudoku <input-file-path> [--validate-only]")
            return .failure(.incorrectArguments)
        }
        else{
            if args[2] == "--validate-only"{
                validateOnly = true
                path = args[1]
            }
            else{
                print("USAGE: sudoku <input-file-path> [--validate-only]")
                return .failure(.incorrectArguments)
            }
        }
    }else{
        path = args[1]
        validateOnly = false
    }
    
    
    // -- Get file path -- //
    let databuffer : Data?
    let filepath = URL(fileURLWithPath: path)
    

    // -- Read sudoku file -- //
    var str = String()
    do {
        databuffer = try Data(contentsOf:filepath)
        str =  String(decoding: databuffer!, as: UTF8.self)
    }
    catch{
        return .failure(.fileError)
    }

    // -- Parse read file into Board -- //
    let parser = Parser()
    let board : Board
    do {
        board = try parser.parseInput(content:str)
    } catch { 
        return .failure(.incorrectFormat)
    }
   

    // -- print out given board -- //
    board.printBoard(title:"Given")

    // -- print arrow to look cool -- //
    board.printArrow() 

    // -- Validate board -- //
    if !board.isValidInput(){
        print("Solution not possible board invalid")
        return .failure(.invalidSudoku)
    }

    // -- Solve sudoku -- //
    var solver = Solver(board:board)
    let solvable = solver.solve()
    
    // -- Print out result -- //
    if solvable{
        // dont print out board if we want to only validate 
        if !validateOnly{
            solver.board.printBoard(title:"Solution")
        }
        else{
            print("Sudoku is solvable.")
        }
        return .success(())
    }else{
        print("Given sudoku is unsolvable !")
        return .failure(.notSolvable)
    }
   
}



// program body
let result = main()

switch result {
case .success:
    break
case .failure(let error):
    var stderr = STDERRStream()
    print("Error:", error.description, to: &stderr)
    exit(Int32(error.code))
}


