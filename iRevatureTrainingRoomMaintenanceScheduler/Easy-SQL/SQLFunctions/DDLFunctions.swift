//
//  QueryFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

extension DatabaseAccess {
//===============================================================================================
    //Create Table
//===============================================================================================
    func createTable(table: SQLiteTable) throws {
        
        //Create prepared statement
        guard let tableStatement = table.makeStatement() else {
            throw SQLiteError.Create(message: "Unable to produce table statement")
        }
        
        let statement = "\(SQLiteKeyword.CREATE) \(tableStatement)"
        
        let createTableStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        //Delete Prepared Statement
        defer {
            sqlite3_finalize(createTableStatement)
        }
        
        //Attempt to execture Prepared Statement
        guard sqlite3_step(createTableStatement) == SQLITE_DONE
            else {
                throw SQLiteError.Step(message: String(cString: sqlite3_errmsg(createTableStatement)))
        }

    }
    
//===============================================================================================
    //Drop Table
//===============================================================================================
    func dropTable(table: SQLiteTable) throws {
        let statement = "\(SQLiteKeyword.DROP) \(SQLiteKeyword.TABLE) \(table.getTableName())"
        let dropStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(dropStatement)
        }
        
        guard sqlite3_step(dropStatement) == SQLITE_DONE else {
            throw SQLiteError.Drop(message: "Failed to drop table from database")
        }
    }
    
}
