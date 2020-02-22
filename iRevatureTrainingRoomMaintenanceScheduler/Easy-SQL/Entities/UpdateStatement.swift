//
//  UpdateStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct UpdateStatement {
    private var table: SQLiteTable
    private var set: [String : Any]
    private var whereAt: WhereStatement?
    
    init (table: SQLiteTable) {
        self.table = table
        self.set = [String : Any]()
    }
    
    mutating func addValueChange(columnToUpdate: String, updatedValue: Any) {
        if set[columnToUpdate] == nil {
            self.set[columnToUpdate] = updatedValue
        }
    }
    
    mutating func setWhereStatement(statement: WhereStatement) {
        self.whereAt = statement
    }
}

extension UpdateStatement: SQLiteStatement {
    func makeStatement() -> String? {
        if table.getColumnsCount() < set.count {
            return nil
        }
        
        guard let setString = makeSetSring(), let atString = whereAt?.makeStatement() else {
            return nil
        }

        return "\(SQLiteKeyword.UPDATE) \(table.getTableName()) \(setString) \(atString);"
    }
    
//===============================================================================================
    //Make A Set Statement
//===============================================================================================
    private func makeSetSring() -> String? {
        var setString: String = "\(SQLiteKeyword.SET) "

        //Iterate through the Values to set in table
        for (index, setHolder) in set.enumerated() {
            
            let columnNameWithReference = table.addTableReference(toColumnName: setHolder.key)
            
            //Add set information
            do {
                setString += "\(setHolder.key) = \(try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnNameWithReference), value: setHolder.value))"
            } catch {
                return nil
            }

            if index < set.count - 1 {
                setString += ", "
            }
        }

        return setString
    }

}
