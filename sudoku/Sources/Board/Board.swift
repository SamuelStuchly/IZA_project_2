public struct Board{
    public var layout : [[Int]]

    public init(layout: [[Int]]){
        self.layout = layout
    }

    public func isValidInput() -> Bool {

        // rows are ok 
        for i in 0..<9{
            var valuesList = [Int]()
            for j in 0..<9{
                if self.layout[i][j] != 0 && valuesList.contains(self.layout[i][j]){
                    return false
                }
                valuesList.append(self.layout[i][j])
            }

        }

        // coulmns are ok 
        for i in 0..<9{
            var valuesList = [Int]()
            for j in 0..<9{
                if self.layout[j][i] != 0 && valuesList.contains(self.layout[j][i]){
                    
                    return false
                }
                valuesList.append(self.layout[j][i])
            }

        }

        // check box 
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
        return true
    }


        // function prints out board 
    public func printBoard(text:String){
        print(" " + text + " :")
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
}