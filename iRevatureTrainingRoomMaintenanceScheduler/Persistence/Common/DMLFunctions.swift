//
//  DDMFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

extension DatabaseAccess {
//===============================================================================================
    //Insert into table
//===============================================================================================
    func insertRow (table: SQLTable.Type, values: Any...) throws {
        if (table.columns.count != values.count) {
            throw SQLiteError.Insert(message: "Incorrect number of values for columns")
        }

        //Prepare the SQL statement
        let statement = try makeInsertStatement(table: table, values: values)
        let insertStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        //Run after function finished to destroy statement
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        //Run the SQL statement
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Insert(message: String(cString: sqlite3_errmsg(insertStatement)))
        }
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Insert Row Statement
//-----------------------------------------------------------------------------------------------
    fileprivate func makeInsertStatement(table: SQLTable.Type, values: [Any]) throws -> String {
        var insertIDString: String = ""
        var insertValueString: String = ""
        
        //Iterate through table columns
        for (index, column) in table.columns.enumerated() {
            //Add start statements
            if (index == 0) {
                insertIDString += "("
                insertValueString += "("
            }
            
            //Add column name
            insertIDString += column.key
            
            //Add column values
            insertValueString += try castToDataType(column: column.value, value: values[index])
            
            //Add spaces
            if index < table.columns.count - 1 {
                insertIDString += ", "
                insertValueString += ", "
            }
        }
        
        //Add end statements
        insertIDString += ")"
        insertValueString += ")"
        
        return "\(SQLiteKeyword.INSERT) \(SQLiteKeyword.INTO) \(table) \(insertIDString) \(SQLiteKeyword.VALUES) \(insertValueString);"
    }
    
//===============================================================================================
    //Update Table Row
//===============================================================================================
    func updateRow(table: SQLTable.Type, set: [String: Any], at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws {
        //Check to make sure that the amount of data matches the table
        if (table.columns.count < set.count || table.columns.count < at.count) {
            throw SQLiteError.Update(message: "More values from set/at than table has")
        }
        
        //Prepare the SQL statement
        let statement = try makeUpdateStatement(table: table, set: set, at: at)
        let updateStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        //Call after function to destroy statement
        defer {
            sqlite3_finalize(updateStatement)
        }
        
        //Run the SQL statement
        guard sqlite3_step(updateStatement) == SQLITE_DONE else {
            throw SQLiteError.Update(message: String(cString: sqlite3_errmsg(updateStatement)))
        }
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Update Table Statement
//-----------------------------------------------------------------------------------------------
    func makeUpdateStatement(table: SQLTable.Type, set: [String: Any], at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws -> String {
        var setString: String = ""
        var atString: String = ""
        
        //Iterate through the Values to set in table
        for (index, setHolder) in set.enumerated() {
            //Add set information
            setString += "\(setHolder.key) = \(try castToDataType(column: table.columns[setHolder.key], value: setHolder.value))"
            
            if index < set.count - 1 {
                setString += ", "
            }
        }
        
        atString = try makeWhereStatement(table: table, at: at)
        
        return "\(SQLiteKeyword.UPDATE) \(table) \(SQLiteKeyword.SET) \(setString) \(atString);"
    }
    
//===============================================================================================
    //Delete Row From Table
//===============================================================================================
    func deleteRow(table: SQLTable.Type, at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws {
        //Check to make sure that the amount of data matches the table
        if (table.columns.count < at.count) {
            throw SQLiteError.Update(message: "More values from at than table has")
        }
        
        //Prepare the SQL statement
        let statement = try makeDeleteStatement(table: table, at: at)
        let deleteStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        print(statement)
        
        //Call after function to destroy statement
        defer {
            sqlite3_finalize(deleteStatement)
        }
        
        //Run the SQL statement
        guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
            throw SQLiteError.Update(message: String(cString: sqlite3_errmsg(deleteStatement)))
        }
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Update Table Statement
//-----------------------------------------------------------------------------------------------
    func makeDeleteStatement(table: SQLTable.Type, at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws -> String {
        var atString: String = ""
        
        atString = try makeWhereStatement(table: table, at: at)
        
        return "\(SQLiteKeyword.DELETE) \(SQLiteKeyword.FROM) \(table) \(atString);"
    }
}

extension DatabaseAccess {
    //Check to see if the value is matching the table type
    private func castToDataType (column: Column?, value: Any) throws -> String {
        
        switch column?.dataType {
        case .CHAR:
            guard let stringValue = value as? String else {
                throw SQLiteError.DataType(message: "Value is not of type String")
            }
            return "'\(stringValue)'"
        case .INT:
            guard let intValue = value as? Int else {
                throw SQLiteError.DataType(message: "Value is not of type Int")
            }
            return String(intValue)
        case .none:
            throw SQLiteError.DataType(message: "Column is nil")
        }
    }
    
    private func makeWhereStatement(table: SQLTable.Type, at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws -> String {
        var whereString = "\(SQLiteKeyword.WHERE) "
        
        //Iterate though the Values to check at certain columns
        for (index, atHolder) in at.enumerated() {
            let conjunctionStatement = atHolder.value.0
            let expression = atHolder.value.2
            let value = atHolder.value.1
            
            //Add to where information
            switch conjunctionStatement {
            case .NONE:
                break
            default:
                whereString += "\(conjunctionStatement) "
            }
            
            whereString += "\(atHolder.key)"
            
            switch expression {
            case .LESSTHAN, .GREATERTHAN, .EQUALS, .LESSTHANEQUALS, .GREATERTHANEQUALS:
                whereString += " \(expression.rawValue) \(try castToDataType(column: table.columns[atHolder.key], value: value))"
                
            case .BETWEEN:
                let tempArray = value as! [Any]
                if tempArray.count != 2 {
                    throw SQLiteError.Update(message: "Error assigning BETWEEN expression")
                }
                whereString += " \(expression.rawValue) \(try castToDataType(column: table.columns[atHolder.key], value: tempArray[0])) \(SQLiteStatement.AND) \(try castToDataType(column: table.columns[atHolder.key], value: tempArray[1]))"
                
            case .IN, .NOTIN:
                let tempArray = value as! [Any]
                
                whereString += " \(expression.rawValue) "
                
                for (index, element) in tempArray.enumerated() {
                    if index == 0 {
                        whereString += "("
                    }
                    
                    whereString += try castToDataType(column: table.columns[atHolder.key], value: element)
                    
                    if index < tempArray.count - 1 {
                        whereString += ", "
                    }
                    else {
                        whereString += ")"
                    }
                }
            }
            
            if index < at.count - 1 {
                whereString += " "
            }
        }
        
        return whereString
    }
}
