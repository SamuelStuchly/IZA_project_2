import Foundation
import Board
import Parser
import Solver


func printArrow(){
    print("             ||")
    print("             ||")
    print("            \\  /")
    print("             \\/")
}



func main(){
    // -- Get filepath -- //
    let path : String
    let args = CommandLine.arguments
    if args.count != 2 {
        print("USAGE: sudoku <input-file-path> ")
        return
        //return .failure(.incorrectArguments)
    }else{
        path = args[1]
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
        print("COULDNT READ THE FILE")
         //return .failure(.fileError)
    }

    // -- Parse read file into Board -- //
    let parser = Parser()
    let board : Board

    board = parser.parseFile(content:str)
    board.printBoard(text:"Given")
   

    // -- Validate board -- //
    if !board.isValidInput(){
        print("Solution not possible board invalid")
        return 
    }
    // -- print pretty arrow :) -- //
    printArrow()

    // -- Solve sudoku-- //
    var solver = Solver(board:board)
    let solvable = solver.solve()
    if solvable{
        solver.board.printBoard(text:"Solution")
    }else{
        print("Given sudoku is unsolvable !")
    }
   
}



// ========= MAIN ========= //
main()


