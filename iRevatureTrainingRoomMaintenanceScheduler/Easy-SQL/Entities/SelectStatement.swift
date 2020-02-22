//
//  SelectStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct SelectStatement {
    private var table: SQLiteTable?
    private var columnNames: [String : (table: SQLiteTable, alias: String)]
    private var joinStatement: JoinStatement?
    private var whereAt: WhereStatement?
    
    init() {
        self.columnNames = [String: (SQLiteTable, String)]()
    }
    
    mutating func getAllColumns(fromTable: SQLiteTable) {
        self.table = fromTable
    }
    
    mutating func specifyColumn(table: SQLiteTable, columnName: String, asName: String) {
        let tableReferenceColumnName = table.addTableReference(toColumnName: columnName)
        self.columnNames[tableReferenceColumnName] = (table, asName)
    }
    
    mutating func setJoinStatement(statement: JoinStatement) {
        self.joinStatement = statement
    }
    
    mutating func setWhereStatement(statement: WhereStatement) {
        self.whereAt = statement
    }
    
}

//Getters
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

//Make String
extension SelectStatement: SQLiteStatement {
    //Makes a full Select Statement string for use in SQL
    func makeStatement() -> String? {
        
        var singleTableString = ""
        var joinString = ""
        var whereString = ""
        
        //If there is a JoinStatement, add it to the SelectStatement
        //If a JoinStatement does not exist, a table reference is required to get all columns
        //If a Table or JoinStatement are not found, fail out
        if self.joinStatement != nil {
            if let joinHolder = self.joinStatement?.makeStatement() {
                joinString = " " + joinHolder
            }
        }
        else if let table = self.table != nil ? self.table?.getTableName() : self.columnNames.first?.value.table.getTableName() {
            singleTableString = " \(SQLiteKeyword.FROM) \(table)"
        }
        else {
            return nil
        }
        
        //If the WhereStatement exists, add it to the SelectStatement
        if let whereHolder = self.whereAt?.makeStatement() {
            whereString = " " + whereHolder
        }
        
        //Return the full SQL string
        return "\(SQLiteKeyword.SELECT) \(makeColumnNamesString()) \(singleTableString)\(joinString)\(whereString);"
    }
    
    //Makes the column section of the Select Statement to access variables from SQL databse
    private func makeColumnNamesString() -> String {
        var columnNamesString: String = ""
        
        //Returns All Columns (*) if column names are not specified
        if table != nil {
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
