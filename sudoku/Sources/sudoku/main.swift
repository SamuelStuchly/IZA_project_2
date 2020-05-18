import Foundation
import Board
import Parser
import Solver


func main() -> Result<Void, RunError> {
    // -- Get filepath -- //
    let validateOnly : Bool
    let path : String
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
        //return .failure(.incorrectArguments)
    }else{
        path = args[1]
        validateOnly = false
    }
    
    // -- Read sudoku file -- //
    let databuffer : Data?
    let filepath = URL(fileURLWithPath: path)
    var str = ""
    do {
        databuffer = try Data(contentsOf:filepath)
        if databuffer != nil{
        str =  String(decoding: databuffer!, as: UTF8.self)
    }
    }
    catch{
       // print("COULDNT READ THE FILE")
        return .failure(.fileError)
    }

    // -- Parse read file into Board -- //
    let parser = Parser()
    let board : Board
    do {
        board = try parser.parseFile(content:str)
    } catch{
        return .failure(.missingTitle)
    }
    
    board.printBoard(text:"Given")
   

    
    // -- print pretty arrow :) -- //
    board.printArrow()

    // -- Validate board -- //
    if !board.isValidInput(){
        print("Solution not possible board invalid")
        return .failure(.invalidSudoku)
    }

    // -- Solve sudoku-- //
    var solver = Solver(board:board)
    let solvable = solver.solve()
    
    if solvable{
        // dont print out board if we want to only validate 
        if !validateOnly{
            solver.board.printBoard(text:"Solution")
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



// ========= MAIN ========= //
let result = main()

switch result {
case .success:
    break
case .failure(let error):
    var stderr = STDERRStream()
    print("Error:", error.description, to: &stderr)
    exit(Int32(error.code))
}


