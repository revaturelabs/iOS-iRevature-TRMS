//
//  JoinStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct JoinStatement {
    private var initialTable: SQLiteTable
    private var joiningTables: [(joinType: SQLiteJoin, joiningTable: SQLiteTable, onPreviousTableColumn: String, onThisTableColumn: String)]
    
    init(table1: SQLiteTable, joinType: SQLiteJoin, table2: SQLiteTable, onColumnName1: String, onColumnName2: String) {
        self.initialTable = table1
  
        let columnName1 = table1.addTableReference(toColumnName: onColumnName1)
        let columnName2 = table2.addTableReference(toColumnName: onColumnName2)
        
        self.joiningTables = [(joinType: SQLiteJoin, joiningTable: SQLiteTable, onPreviousTableColumn: String, onThisTableColumn: String)]()
        self.joiningTables.append((joinType, table2, columnName1, columnName2))
    }
    
    mutating func appendJoin(joinType: SQLiteJoin, table: SQLiteTable, onPreviousTableColumnName: String, onThisTableColumnName: String) {
        
        let previousTable = self.joiningTables[self.joiningTables.count - 1].joiningTable
        
        let columnName1 = previousTable.addTableReference(toColumnName: onPreviousTableColumnName)
        let columnName2 = table.addTableReference(toColumnName: onThisTableColumnName)
        
        self.joiningTables.append((joinType, table, columnName1, columnName2))
    }
}

extension JoinStatement: SQLiteStatement {
    func makeStatement() -> String? {
        
        var joinString = initialTable.getTableName()
        
        for joinTable in self.joiningTables {
            joinString += " \(joinTable.joinType.rawValue)"
            joinString += " \(joinTable.joiningTable.getTableName())"
            joinString += " \(SQLiteKeyword.ON)"
            joinString += " \(joinTable.onPreviousTableColumn) = \(joinTable.onThisTableColumn)"
        }
        
        return "\(SQLiteKeyword.FROM) \(joinString)"
    }
    
    
}
