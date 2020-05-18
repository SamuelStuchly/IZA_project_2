import Board

public struct Solver {

    public var board : Board

    public init(board: Board) {
        self.board = board
    }

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



    private func isValid(number:Int,position:(column:Int,row:Int)) -> Bool {

        // check row 
        for i in 0..<self.board.layout[position.row].count{
            if self.board.layout[position.row][i] == number && position.column != i{
                return false
            }
        }

        // check coulmn
        for i in 0..<self.board.layout.count{
            if self.board.layout[i][position.column] == number && position.row != i{
                return false
            }
        }

        // check box 
        let box_x = Int(position.column / 3)
        let box_y = Int(position.row / 3)


        for i in (box_y*3)..<(box_y * 3 + 3){
            for j in (box_x*3)..<(box_x * 3 + 3){
                if self.board.layout[i][j] == number && (i,j) != position{
                
                    return false
                }
            }
        }

        return true
    }


    public mutating func solve()-> Bool{
        let foundSpot = getFirstEmptySpot()
        if foundSpot == (-1,-1){
            return true
        }
        
        let row = foundSpot.row
        let column = foundSpot.column
    


        for i in 1...9{
            if isValid(number:i,position:(column:column,row:row)){
                self.board.layout[row][column] = i
                
                
                if solve(){
                    return true
                }
                else{
                    self.board.layout[row][column] = 0
                }
            }
        }
        return false
    }


}