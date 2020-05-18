import Foundation
import Board



public struct Parser{

    

    public init(){}


   public func parseFile(content:String) throws -> Board  {
        let rows = content.components(separatedBy:"\n")
        var myBoard = rows.map{ $0.replacingOccurrences(of: " ", with: "") }

        // read the file
        if myBoard[0] != "SUDOKU"{
            print("MISSING TITLE")
            throw "missing title"
        }
        myBoard.removeFirst()

        let lineSepArr = [0,4,8,12]
        for i in 0..<13{
        let currentRow = Array(myBoard[i])
        //print(currentRow)
        
        if lineSepArr.contains(i) {
            for j in currentRow{
                if j != "-"{
                    print("horizontal seperation not ok ")
                    //throw MyError.runtimeError("INCORRECT BOARD FORMAT")
                    
                }
            }
        }
        else{
            for (index,value) in currentRow.enumerated(){
                if lineSepArr.contains(index){

                        if value != "|"{
                        print("vertical seperation not ok ")
                        break
                        }
                    } 
            }
        }
        }
        var boardWithoutSeperators = [String]()

        for i in 0..<13{
            if lineSepArr.contains(i){
                continue
            } 
            else{
                boardWithoutSeperators.append(myBoard[i])
            
                
            }
        }
        var newBoard = [[Int]]()
        for i in boardWithoutSeperators{
            
            var row = Array(i)
            
            row.remove(at:0)
            row.remove(at:4 - 1)
            row.remove(at:8 - 2)
            row.remove(at:12 - 3)
            let intRow = row.map{ Int(String($0))! }
            newBoard.append(intRow)
        }
        
        let returnedBoard = Board(layout:newBoard)
        return returnedBoard
    }
}

extension String: Error {}