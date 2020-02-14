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
        let statement = makeCreateStatement(tableName: table, tableColumns: table.columns)
        
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
                throw SQLiteError.Step(message: SQLiteErrorMessage.tableCreationError)
        }
        print("\(table) table created")
        os_log("%{table} table created", log: OSLog.default, type: .info)
    }
    
//-----------------------------------------------------------------------------------------------
    private func makeCreateStatement (tableName: SQLTable.Type, tableColumns: [Column]) -> String {
        var columns: String = ""
        
        //Make table columns in proper format
        for i in 0 ..< tableColumns.count {

            //Assign column name
            columns += tableColumns[i].name
            
            //Assign datatype formatting
            switch tableColumns[i].dataType {
            case .CHAR:
                columns += " \(tableColumns[i].dataType.rawValue)(255)"
            default:
                columns += " \(tableColumns[i].dataType.rawValue)"
            }

            //Assign column constraints
            if tableColumns[i].constraints != nil {
                for k in 0 ..< tableColumns[i].constraints!.count {
                    columns += " \(tableColumns[i].constraints![k].rawValue)"
                }
            }
            
            //Apply comma for new column
            if (i != tableColumns.count - 1) {
                columns += ", "
            }
        }
        
        return "\(SQLiteKeyword.CREATE) \(SQLiteKeyword.TABLE) \(tableName) (\(columns));"
    }
    
}
