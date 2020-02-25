//
//  InsertStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct InsertStatement {
    private var table: SQLiteTable
    private var columnValues: [Any]?
    private var columnInfo: [(columnName: String, columnValue: Any)]?
    
    init (table: SQLiteTable, columnValues: Any...) {
        self.table = table
        self.columnValues = columnValues
    }
    
    init (table: SQLiteTable) {
        self.table = table
        self.columnInfo = [(columnName: String, columnValue: Any)]()
    }
    
    func getTable() -> SQLiteTable {
        return self.table
    }
    
    func getColumnValuesCount() -> Int {
        guard let columnCount = self.columnValues?.count else {
            return 0
        }
        
        return columnCount
    }
}

extension InsertStatement {
    mutating func specifyValue(columnName: String, columnValue: Any) {
        guard let columnInfo = self.columnInfo else {
            return
        }
        
        for (name, _) in columnInfo {
            if name == columnName {
                return
            }
        }
        
        self.columnInfo!.append((columnName: columnName, columnValue: columnValue))
    }
}

extension InsertStatement: SQLiteStatement {
    func makeStatement() -> String? {
        guard let columnString = columnValues != nil ? table.makeColumnNameString(withTableReference: false) : makeColumnString() else {
            print("fail 1")
            return nil
        }
        
        guard let valueString = makeValueString() else {
            print("fail 2")
            return nil
        }
        
        return "\(SQLiteKeyword.INSERT) \(SQLiteKeyword.INTO) \(table.getTableName()) \(columnString) \(valueString);"
    }
    
    private func makeColumnString() -> String? {
        if let columnInfo = self.columnInfo {
            if columnInfo.isEmpty {
                return nil
            }
        }
        
        var columnNameString = "("
        
        for (index, column) in columnInfo!.enumerated() {
            columnNameString += column.columnName
            
            if index < columnInfo!.count - 1 {
                columnNameString += ", "
            }
        }
        
        columnNameString += ")"
        
        return columnNameString
    }
    
//===============================================================================================
    //Make A Values Statement
//===============================================================================================
    private func makeValueString() -> String? {
        if self.columnValues == nil && self.columnInfo!.isEmpty {
            return nil
        }
        else if columnValues != nil && table.getColumnsCount() != getColumnValuesCount() {
            return nil
        }
        
        var insertValueString: String = "\(SQLiteKeyword.VALUES) "

        var columnValues: [Any]
        var columnNames: [String]
        
        if self.columnValues == nil {
            columnNames = [String]()
            columnValues = [Any]()
            
            for (name, value) in self.columnInfo! {
                columnNames.append(table.addTableReferenceTo(columnName: name))
                columnValues.append(value)
            }
        }
        else {
            columnNames = table.getAllColumnNames(withTableReference: true)!
            columnValues = self.columnValues!
        }
        
        insertValueString += "("
        
        //Iterate through table columns
        for (index, value) in columnValues.enumerated() {
            //Add column values
            do {
                insertValueString += try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnNames[index]), value: value)
            } catch {
                return nil
            }

            //Add spaces
            if index < columnValues.count - 1 {
                insertValueString += ", "
            }
            else {
                insertValueString += ")"
            }
        }

        return insertValueString
    }
    
}
