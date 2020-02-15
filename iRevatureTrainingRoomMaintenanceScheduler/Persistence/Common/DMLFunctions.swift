//
//  DDMFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3
import os.log

extension DatabaseAccess {
//===============================================================================================
    //Insert into table
//===============================================================================================
    func insertRow (table: SQLTable.Type, values: [String]) throws {
        if (table.columns.count != values.count) {
            os_log(SQLiteErrorMessage.tableInsertionError, log: OSLog.default, type: .error)
            throw SQLiteError.Insert(message: SQLiteErrorMessage.tableInsertionError)
        }

        let statement = try makeInsertStatement(table: table, values: values)
        let insertStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            os_log(SQLiteErrorMessage.tableInsertionError, log: OSLog.default, type: .error)
            throw SQLiteError.Insert(message: SQLiteErrorMessage.tableInsertionError)
        }
        
        os_log(SQLiteSuccessMessage.tableInsertionSuccess, log: OSLog.default, type: .info)
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Create Table Statement
//-----------------------------------------------------------------------------------------------
    fileprivate func makeInsertStatement(table: SQLTable.Type, values: [String]) throws -> String {
        var insertIDString: String = ""
        var insertValueString: String = ""
        var index: Int = 0
        
        for (key, value) in table.columns {
            //Add start statements
            if (index == 0) {
                insertIDString += "("
                insertValueString += "("
            }
            
            //Add column name
            insertIDString += key
            
            //Add value
            switch value.dataType {
            case .CHAR:
                insertValueString += "'\(values[index])'"
            case .INT:
                if Int(values[index]) == nil {
                    throw SQLiteError.Insert(message: SQLiteErrorMessage.tableInsertionError)
                }
                insertValueString += values[index]
            }
            
            index += 1
            
            //Add spaces
            if index < table.columns.count {
                insertIDString += ", "
                insertValueString += ", "
            }
        }
        
        //Add end statements
        insertIDString += ")"
        insertValueString += ");"
        
        return "\(SQLiteKeyword.INSERT) \(SQLiteKeyword.INTO) \(table) \(insertIDString) \(SQLiteKeyword.VALUES) \(insertValueString)"
    }
}
