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
                throw SQLiteError.Step(message: String(cString: sqlite3_errmsg(createTableStatement)))
        }

    }
    
//-----------------------------------------------------------------------------------------------
    //Make Create Table Statement
//-----------------------------------------------------------------------------------------------
    private func makeCreateStatement (table: SQLTable.Type) -> String {
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
    
//===============================================================================================
    //Create Table
//===============================================================================================
    func dropTable(table: SQLTable.Type) throws {
        let statement = makeDropTableStatement(table: table)
        let dropStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(dropStatement)
        }
        
        guard sqlite3_step(dropStatement) == SQLITE_DONE else {
            throw SQLiteError.Drop(message: "Failed to drop table from database")
        }
    }
    
//-----------------------------------------------------------------------------------------------
    //Make Drop Table Statement
//-----------------------------------------------------------------------------------------------
    private func makeDropTableStatement(table: SQLTable.Type) -> String{
        return "\(SQLiteKeyword.DROP) \(SQLiteKeyword.TABLE) \(table)"
    }
}
