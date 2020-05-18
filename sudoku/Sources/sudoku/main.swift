import Foundation


print("Hello, world!")

enum MyError: Error {
    case runtimeError(String)
}


 var board = Array(repeating: Array(repeating: 0, count: 9), count: 9)

// function prints out board 
func printBoard(){
    print("         SUDOKU")
    var rowCount = 0
    print("-------------------------")
    for row in board{
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


func getFirstEmptySpot() -> (column:Int,row:Int){
    for (i,row) in board.enumerated(){
        for (j,column) in row.enumerated(){
            if column == 0 {
                return (j,i) // j = column, i = row            
            }
        }
    }
    //print("NO MORE EMPTY SPACEs")
    return (-1,-1)
}



func isValid(number:Int,position:(column:Int,row:Int)) -> Bool {

    // check row 
    for i in 0..<board[position.row].count{
        //print("Stlpec " + String(i))
        if board[position.row][i] == number && position.column != i{
            return false
        }
    }

    // check coulmn
    for i in 0..<board.count{
        //print("Riadok " + String(i))
        if board[i][position.column] == number && position.row != i{
            return false
        }
    }

    // check box 
    let box_x = Int(position.column / 3)
    let box_y = Int(position.row / 3)
    //print("V boxe")
    //print(box_x)
    //print(box_y)

    for i in (box_y*3)..<(box_y * 3 + 3){
        for j in (box_x*3)..<(box_x * 3 + 3){
            if board[i][j] == number && (i,j) != position{
                // print(j)
                // print(i)

                // print(number)
                // print(board[j])
                
                // print("som false z boxu")
                // print((i,j) != position)
                return false
            }
        }
    }

    //print("ISVALID")
    return true


}


func solver()-> Bool{
    //print("IM in solver")
    let foundSpot = getFirstEmptySpot()
    if foundSpot == (-1,-1){
        //print("KONCIM")
        return true
    }
    
    let row = foundSpot.row
    let column = foundSpot.column
   


    for i in 1...9{
       //print("Value " + String(i))
        if isValid(number:i,position:(column:column,row:row)){
            board[row][column] = i
            //printBoard()
            //print("SOLVER POSTUPUJE")
            
            if solver(){
                return true
            }
            else{
                board[row][column] = 0
            }
        }
    }
    //print("SOLVER sa vracia spat ==")
    return false
}

func parseFile(content:String) throws -> [[Int]]  {
    let rows = content.components(separatedBy:"\n")
    //print(rows)
    var myBoard = rows.map{ $0.replacingOccurrences(of: " ", with: "") }
    //print(myBoard)

    // read the file
    if myBoard[0] != "SUDOKU"{
        print("MISSING TITLE")
        throw MyError.runtimeError("INCORRECT BOARD FORMAT")
    }
    myBoard.removeFirst()

    var lineSepArr = [0,4,8,12]
    for i in 0..<13{
       var currentRow = Array(myBoard[i])
       //print(currentRow)
       
       if lineSepArr.contains(i) {
           for j in currentRow{
               if j != "-"{
                   print("horizontal seperation not ok ")
                   throw MyError.runtimeError("INCORRECT BOARD FORMAT")
                   
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
    print("board format ok")
    var boardWithoutSeperators = [String]()

    for i in 0..<13{
        if lineSepArr.contains(i){
            continue
        } 
        else{
            boardWithoutSeperators.append(myBoard[i])
           
            
        }
    }
    //print(boardWithoutSeperators)
    var newBoard = [[Int]]()
    for i in boardWithoutSeperators{
        
        var row = Array(i)
        
        row.remove(at:0)
        row.remove(at:4 - 1)
        row.remove(at:8 - 2)
        row.remove(at:12 - 3)
        var hello = row.map{ Int(String($0))! }
        // print(hello)
        // print(type(of:hello))
        newBoard.append(hello)
        
        
        

    }
    
    //print(newBoard)
    
    return newBoard


    

    
}


func openAndReadFile() -> [[Int]]{
    let path : String
    let args = CommandLine.arguments
    path = args[1]
    print(path)

// -------- open the file and get data---------
    
    let databuffer : Data?
    let filepath = URL(fileURLWithPath: path)
    var str = ""
    do {
        databuffer = try Data(contentsOf:filepath)
        if databuffer != nil{
        str =  try String(decoding: databuffer!, as: UTF8.self)
        print(str)
    }
        //print(type(of:databuffer))
    }
    catch{
        print("COULDNT READ THE FILE")
         //return .failure(.fileError)
    }
    do {
        let board = try parseFile(content:str)
        return board
    }
    catch {
        print("Incorrect format")
    }

   
   return [[]]
   
}


func isValidInput(myBoard:[[Int]]) -> Bool {

    // rows are ok 
    for i in 0..<9{
        var valuesList = [Int]()
        for j in 0..<9{
            if myBoard[i][j] != 0 && valuesList.contains(myBoard[i][j]){
                return false
            }
            valuesList.append(myBoard[i][j])
        }

    }
    print("rows are fine")

    // coulmns are ok 
    for i in 0..<9{
        var valuesList = [Int]()
        for j in 0..<9{
            if myBoard[j][i] != 0 && valuesList.contains(myBoard[j][i]){
                
                return false
            }
            valuesList.append(myBoard[j][i])
        }

    }
    print("columns are fine")

    // check box 
    for i in 0..<3{
        
        for j in 0..<3{
            let box_x = i
            let box_y = j
        
            var valuesList = [Int]()
            for i in (box_y*3)..<(box_y * 3 + 3){
                for j in (box_x*3)..<(box_x * 3 + 3){
                    if myBoard[i][j] != 0 && valuesList.contains(myBoard[i][j]){
                      
                        return false
                    }
                    valuesList.append(myBoard[i][j])
                }
            }
            //print(valuesList)
        }
    }
    print("boxes are fine")
    return true
}

func main(){
    print("\n =========================================\n")
    //setMediumBoard()
    board = openAndReadFile()
    printBoard()
    if !isValidInput(myBoard:board){
        print("Solution not possible board invalid")
        return 
    }
    if solver(){
        print("Here is a solution :")
        printBoard()
    }else{
        print("Given sudoku is unsolvable !")
    }
   
}



// ========= MAIN ========= //
main()

// board = openAndReadFile()
// print(isValidInput(myBoard:board))

