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
    private func makeCreateStatement (tableName: SQLTable.Type, tableColumns: [String: Column]) -> String {
        var columnString: String = ""
        
        var columnIterator = tableColumns.makeIterator()
        
        while (true) {
            guard let column = columnIterator.next() else {
                break
            }
            
            //Apply comma for new column
            if (column.key != tableColumns.first?.key) {
                columnString += ", "
            }
            
            //Assign column name
            columnString += column.key
            
            //Assign datatype formatting
            switch column.value.dataType {
            case .CHAR:
                columnString += " \(column.value.dataType.rawValue)(255)"
            default:
                columnString += " \(column.value.dataType.rawValue)"
            }

            //Assign column constraints
            if column.value.constraints != nil {
                for i in 0 ..< column.value.constraints!.count {
                    columnString += " \(column.value.constraints![i].rawValue)"
                }
            }

        }
        
        return "\(SQLiteKeyword.CREATE) \(SQLiteKeyword.TABLE) \(tableName) (\(columnString));"
    }
    
}
