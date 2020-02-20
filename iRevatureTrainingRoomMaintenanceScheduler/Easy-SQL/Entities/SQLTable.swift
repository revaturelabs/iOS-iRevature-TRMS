//
//  Table.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//


struct Column {
    var dataType: SQLiteDataType
    var constraints: [SQLiteConstraints]?
}

struct SQLiteTable {
    private var tableName: String
    private var columnData: [(columnName: String, columnInfo: Column)]
    
    init(tableName: String) {
        columnData = [(columnName: String, columnInfo: Column)]()
        self.tableName = tableName
    }
    
    mutating func addColumn(columnName: String, dataType: SQLiteDataType, constraints: SQLiteConstraints?...) {
        let columnInfo = Column(dataType: dataType, constraints: constraints as? [SQLiteConstraints])
        
        for column in self.columnData {
            if column.columnName == columnName {
                return
            }
        }
        
        self.columnData.append((columnName, columnInfo))
        
//        if columnData[columnName] == nil {
//            columnData[columnName] = Column(dataType: dataType, constraints: constraints as? [SQLiteConstraints])
//            //return true
//        }
        
        //return false
    }
}

//===============================================================================================
    //Getters
//===============================================================================================
extension SQLiteTable {
    func getTableName() -> String {
        return tableName
    }
    
    func getAllColumnNames() -> [String]? {
        var columnNames: [String] = [String]()
        
        for (columnName, _) in columnData {
            columnNames.append(columnName)
        }
        
        if columnNames.count != 0 {
            return columnNames
        }
        
        return nil
    }
    
    func getColumnData(columnName: String) -> Column? {
        for column in self.columnData {
            if column.columnName == columnName {
                return column.columnInfo
            }
        }
        
        return nil
    }
    
    func getAllColumns() -> [(columnName: String, columnInfo: Column)] {
        return self.columnData
    }
    
    func getColumnsCount() -> Int {
        return columnData.count
    }
}


extension SQLiteTable: SQLiteStatement {
//===============================================================================================
    //Make A Table Statement
//===============================================================================================
    func makeStatement() -> String? {
        var columnString: String = "\(SQLiteKeyword.TABLE) \(tableName) "

        for (index, column) in getAllColumns().enumerated() {
            //Apply comma for new column
            if index == 0 {
                columnString += "("
            }
            else {
                columnString += ", "
            }

            //Assign column name
            columnString += column.columnName
            
            //Apply the data types
            columnString += makeDataTypeString(dataType: column.columnInfo.dataType)

            //Assign column constraints
            if column.columnInfo.constraints != nil {
                for i in 0 ..< column.columnInfo.constraints!.count {
                    columnString += " \(column.columnInfo.constraints![i].rawValue)"
                }
            }
        }

        columnString += ")"

        return columnString
    }
    
    private func makeDataTypeString(dataType: SQLiteDataType) -> String {
        //Assign datatype formatting
        switch dataType {
        case .CHAR:
            return " \(dataType.rawValue)(500)"
        default:
            return" \(dataType.rawValue)"
        }
    }
    
    private func makeConstraintString(constraints: [SQLiteConstraints]?) -> String {
        //Assign column constraints
        if constraints != nil {
            var constraintString = ""
            
            for i in 0 ..< constraints!.count {
                constraintString += " \(constraints![i].rawValue)"
            }
            
            return constraintString
        }
        
        return ""
    }
    
    func makeColumnNameString() -> String? {
        guard let columnNames = getAllColumnNames() else {
            return nil
        }
        
        var columnNamesString = ""
        
        for (index, name) in columnNames.enumerated() {
            //Add start statements
            if (index == 0) {
                columnNamesString += "("
            }

            //Add column name
            columnNamesString += name

            //Add spaces
            if index < columnNames.count - 1 {
                columnNamesString += ", "
            }
            else {
                columnNamesString += ")"
            }
        }
        
        return columnNamesString
    }
}

