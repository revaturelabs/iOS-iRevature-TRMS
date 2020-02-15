//
//  QueryFunctions.swift
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
    //Create Table
//===============================================================================================
    func createTable(table: SQLTable.Type) throws {
        //Create table creation string
        let statement = makeCreateStatement(table: table)
        
        //Create prepared statement
        let createTableStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        //Delete Prepared Statement
        defer {
            sqlite3_finalize(createTableStatement)
        }
        
        //Attempt to execture Prepared Statement
        guard sqlite3_step(createTableStatement) == SQLITE_DONE
            else {
                os_log(SQLiteErrorMessage.tableCreationError, log: OSLog.default, type: .error)
                throw SQLiteError.Step(message: String(cString: sqlite3_errmsg(createTableStatement)))
        }
        
        os_log(SQLiteSuccessMessage.tableCreationSuccess, log: OSLog.default, type: .info)
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Create Table Statement
//-----------------------------------------------------------------------------------------------
    fileprivate func makeCreateStatement (table: SQLTable.Type) -> String {
        var columnString: String = ""
        var hasComma: Bool = false
        
        for (key, value) in table.columns {
            //Apply comma for new column
            if hasComma {
                columnString += ", "
            }
            else {
                columnString += "("
                hasComma = true
            }
            
            //Assign column name
            columnString += key
            
            //Assign datatype formatting
            switch value.dataType {
            case .CHAR:
                columnString += " \(value.dataType.rawValue)(255)"
            default:
                columnString += " \(value.dataType.rawValue)"
            }
            
            //Assign column constraints
            if value.constraints != nil {
                for i in 0 ..< value.constraints!.count {
                    columnString += " \(value.constraints![i].rawValue)"
                }
            }
        }
        
        columnString += ");"
        
        return "\(SQLiteKeyword.CREATE) \(SQLiteKeyword.TABLE) \(table) \(columnString)"
    }
    
}
