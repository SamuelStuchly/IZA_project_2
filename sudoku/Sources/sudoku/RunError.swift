//
//  RunError.swift
//  sudoku
//
//  Structure created by Filip Klembara on 17/02/2020.
//  Implemented for SudokuSolver by Samuel Stuchly on 18/05/2020.
//

enum RunError: Error {
    case incorrectArguments
    case fileError
    case invalidSudoku
    case notSolvable
    case incorrectFormat
   
}

// MARK: - Return codes
extension RunError {
    var code: Int {
        switch self {
            case .notSolvable:
                return 1
            case .invalidSudoku:
                return 2 
            case .incorrectFormat:
                return 7
            case .incorrectArguments:
                return 11
            case .fileError:
                return 12
            
            
        
        }
    }
}

// MARK:- Description of error
extension RunError: CustomStringConvertible {
    var description: String {
        switch self {
            case .notSolvable:
                return "Given Sudoku is not solvable!"
            case .invalidSudoku:
                return "Given Sudoku is invalid! (doesnt conform with sudoku rules)"
            case .incorrectArguments:
                return "Invalid arguments!"
            case .fileError:
                return "File Error!"
            case .incorrectFormat:
                return "Incorrect format of the board in input file! (Make sure board has title SUDOKU and format as shown and descripedS in README.md))"
        
        }
    }
}
