//
//  DeleteStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct DeleteStatement {
    var table: SQLiteTable
    var whereAt: WhereStatement?
    
    init (table: SQLiteTable) {
        self.table = table
    }
    
    mutating func setWhereStatement(statement: WhereStatement) {
        self.whereAt = statement
    }
}

extension DeleteStatement: SQLiteStatement {
    func makeStatement() -> String? {
        if let whereStatement = whereAt?.makeStatement() {
            return "\(SQLiteKeyword.DELETE) \(SQLiteKeyword.FROM) \(table.getTableName()) \(whereStatement);"
        }
        
        return nil
    }
}
