//
//  InsertStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct InsertStatement {
    private var table: SQLiteTable
    private var columnValues: [Any]
    
    init (table: SQLiteTable, columnValues: Any...) {
        self.table = table
        self.columnValues = columnValues
    }
    
    func getTable() -> SQLiteTable {
        return self.table
    }
    
    func getColumnValuesCount() -> Int {
        return self.columnValues.count
    }
}

extension InsertStatement: SQLiteStatement {
    func makeStatement() -> String? {
        guard let columnString = table.makeColumnNameString(withTableReference: false), let valueString = makeValueString() else {
            return nil
        }
        
        return "\(SQLiteKeyword.INSERT) \(SQLiteKeyword.INTO) \(table.getTableName()) \(columnString) \(valueString);"
    }
    
//===============================================================================================
    //Make A Values Statement
//===============================================================================================
    private func makeValueString() -> String? {
        if (table.getColumnsCount() != getColumnValuesCount()) {
            return nil
        }
        
        var insertValueString: String = "\(SQLiteKeyword.VALUES) "

        //Iterate through table columns
        for (index, column) in table.getAllColumns().enumerated() {
            //Add start statements
            if (index == 0) {
                insertValueString += "("
            }

            //Add column values
            do {
                insertValueString += try SQLUtility.castToDataType(column: column.columnInfo, value: columnValues[index])
            } catch {
                return nil
            }

            //Add spaces
            if index < table.getColumnsCount() - 1 {
                insertValueString += ", "
            }
            else {
                insertValueString += ")"
            }
        }

        return insertValueString
    }
    
}
