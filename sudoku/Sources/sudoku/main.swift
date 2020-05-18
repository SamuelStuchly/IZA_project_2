print("Hello, world!")


 //var board = Array(repeating: Array(repeating: 0, count: 9), count: 9)

var board = [
    [0,3,0,0,0,8,1,6,0],
    [0,0,5,1,0,2,0,0,9],
    [0,0,0,7,0,4,0,0,0],

    [0,0,0,0,2,0,0,1,3],
    [0,0,2,9,0,5,6,8,7],
    [0,0,7,0,0,3,0,0,0],

    [0,2,6,8,7,0,0,4,0],
    [0,5,0,0,0,9,0,0,0],
    [4,0,0,0,0,6,0,0,0]
]

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
    print("NO MORE EMPTY SPACEs")
    return (-1,-1)
}


func setNumberInBoard(row : Int, column : Int, value : Int ) {
    if value > 9 || value < 1 {
        print("Incorrect value")
    }
    board[row-1][column-1] = value
}

func setMediumBoard(){
    setNumberInBoard(row:9,column:1,value:4)


    setNumberInBoard(row:1,column:2,value:3)
    setNumberInBoard(row:7,column:2,value:2)
    setNumberInBoard(row:8,column:2,value:5)

    setNumberInBoard(row:2,column:3,value:5)
    setNumberInBoard(row:5,column:3,value:2)
    setNumberInBoard(row:6,column:3,value:7)
    setNumberInBoard(row:7,column:3,value:6)

    setNumberInBoard(row:2,column:4,value:1)
    setNumberInBoard(row:3,column:4,value:7)
    setNumberInBoard(row:5,column:4,value:9)
    setNumberInBoard(row:7,column:4,value:8)

    setNumberInBoard(row:4,column:5,value:2)
    setNumberInBoard(row:7,column:5,value:7)

    setNumberInBoard(row:1,column:6,value:8)
    setNumberInBoard(row:2,column:6,value:2)
    setNumberInBoard(row:3,column:6,value:4)
    setNumberInBoard(row:5,column:6,value:5)
    setNumberInBoard(row:6,column:6,value:3)
    setNumberInBoard(row:8,column:6,value:9)
    setNumberInBoard(row:9,column:6,value:6)
    
    setNumberInBoard(row:1,column:7,value:1)
    setNumberInBoard(row:5,column:7,value:6)

    setNumberInBoard(row:1,column:8,value:6)
    setNumberInBoard(row:4,column:8,value:1)
    setNumberInBoard(row:5,column:8,value:8)
    setNumberInBoard(row:7,column:8,value:4)

    setNumberInBoard(row:2,column:9,value:9)
    setNumberInBoard(row:4,column:9,value:3)
    setNumberInBoard(row:5,column:9,value:7)
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


    // // check row 
    // for (j,value) in board[position.1].enumerated(){
    //     if value == number && j != position.0{
    //         return false
    //     } 
    // }

    // // check column
    // for (j,value) in board[position.1].enumerated(){
    //     if value == number && j != position.0{
    //         return false
    //     } 
    // }


}


func solver()-> Bool{
    //print("IM in solver")
    var foundSpot = getFirstEmptySpot()
    if foundSpot == (-1,-1){
        //print("KONCIM")
        return true
    }
    
    var row = foundSpot.row
    var column = foundSpot.column
   


    for i in 1...9{
       //print("Value " + String(i))
        if isValid(number:i,position:(column:column,row:row)){
            board[row][column] = i
            printBoard()
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


func main(){
    print("\n =========================================\n")
    //setMediumBoard()
    printBoard()
    print(solver())
    printBoard()
}



// ========= MAIN ========= //
main()

//print(Int(3/3))
