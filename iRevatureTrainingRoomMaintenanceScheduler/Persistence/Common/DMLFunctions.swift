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
        let tableIdString = SQLUtility.makeColumnNameStatement(table: table)
        let valueString = try SQLUtility.makeValueStatement(table: table, values: values)
        
        let statement = "\(SQLiteKeyword.INSERT) \(SQLiteKeyword.INTO) \(table) \(tableIdString) \(valueString);"
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
    
//===============================================================================================
    //Update Table Row
//===============================================================================================
    func updateRow(table: SQLTable.Type, set: [String: Any], at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws {
        //Check to make sure that the amount of data matches the table
        if (table.columns.count < set.count || table.columns.count < at.count) {
            throw SQLiteError.Update(message: "More values from set/at than table has")
        }
        
        //Prepare the SQL statement
        let setString = try SQLUtility.makeSetStatement(table: table, set: set)
        let atString = try SQLUtility.makeWhereStatement(table: table, at: at)
        
        let statement = "\(SQLiteKeyword.UPDATE) \(table) \(setString) \(atString);"
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
    
//===============================================================================================
    //Delete Row From Table
//===============================================================================================
    func deleteRow(table: SQLTable.Type, at: [String: (SQLiteStatement, Any, SQLiteExpression)]) throws {
        //Check to make sure that the amount of data matches the table
        if (table.columns.count < at.count) {
            throw SQLiteError.Update(message: "More values from at than table has")
        }
        
        //Prepare the SQL statement
        let atString = try SQLUtility.makeWhereStatement(table: table, at: at)
        
        let statement = "\(SQLiteKeyword.DELETE) \(SQLiteKeyword.FROM) \(table) \(atString);"
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
}
