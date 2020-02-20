//
//  SelectStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct SelectStatement {
    //private var table: SQLiteTable?
    private var columnNames: [String : (table: SQLiteTable, alias: String)]
    private var joinStatement: JoinStatement?
    private var whereAt: WhereStatement?
    
    init() {
        self.columnNames = [String: (SQLiteTable, String)]()
    }
    
//    mutating func specifyTable(table: SQLiteTable) {
//        self.table = table
//    }
    
    mutating func specifyColumn(table: SQLiteTable, columnName: String, asName: String) {
        let newColumnName = SQLUtility.getColumnReferencingTableName(table: table, columnName: columnName)
        self.columnNames[newColumnName] = (table, asName)
    }
    
    mutating func setJoinStatement(statement: JoinStatement) {
        self.joinStatement = statement
    }
    
    mutating func setWhereStatement(statement: WhereStatement) {
        self.whereAt = statement
    }
    
}

extension SelectStatement {
    func getColumnNames() -> [String]? {
        if self.columnNames.isEmpty {
            return nil
        }
        
        var nameArray: [String] = [String]()
        
        for name in self.columnNames {
            nameArray.append(name.key)
        }
        
        return nameArray
    }
    
    func getColumnAliases() -> [String]? {
        if self.columnNames.isEmpty {
            return nil
        }
        
        var nameArray: [String] = [String]()
        
        for name in self.columnNames {
            nameArray.append(name.value.alias)
        }
        
        return nameArray
    }
    
    func getColumnAliasByName(columnName: String) -> String? {
        if self.columnNames[columnName] == nil {
            return nil
        }
        
        return self.columnNames[columnName]?.alias
    }
    
    func getColumnNameByAlias(columnAlias: String) -> String? {
        for (name, column) in columnNames {
            if column.alias == columnAlias {
                return name
            }
        }
        
        return nil
    }
    
    func getTableByColumnName(columnName: String) -> SQLiteTable? {
        guard let table = self.columnNames[columnName]?.table else {
            return nil
        }
        
        return table
    }
}

extension SelectStatement: SQLiteStatement {
    func makeStatement() -> String? {
        guard let atString = whereAt?.makeStatement() else {
            return nil
        }
        
        if joinStatement != nil {
            guard let joinString = self.joinStatement?.makeStatement() else {
                return nil
            }
            
            return "\(SQLiteKeyword.SELECT) \(makeColumnNamesString()) \(joinString) \(atString);"
        }
        
        guard let table = columnNames.first?.value.table.getTableName() else {
            return nil
        }
        
        //Prepare full SQL string
        return "\(SQLiteKeyword.SELECT) \(makeColumnNamesString()) \(SQLiteKeyword.FROM) \(table) \(atString);"
    }
    
    private func makeColumnNamesString() -> String {
        var columnNamesString: String = ""
        
        //Assign values to select
        if columnNames.isEmpty {
            return "*"
        }
        
        for (index, name) in columnNames.enumerated() {
            columnNamesString += name.key
            columnNamesString += " \(SQLiteKeyword.AS) "
            columnNamesString += name.value.alias

            if index < columnNames.count - 1 {
                columnNamesString += ", "
            }
        }
        
        return columnNamesString
    }
    
}
