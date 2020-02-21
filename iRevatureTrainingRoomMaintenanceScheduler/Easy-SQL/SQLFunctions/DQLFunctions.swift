//
//  DQLFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3

extension DatabaseAccess {
//===============================================================================================
    //Select Data From Table
//===============================================================================================
    func selectData(statement: SelectStatement) throws -> [[String: Any]]? {
        
        //Prepare statement
        guard let statementHolder = statement.makeStatement() else {
            throw SQLiteError.Query(message: "Unable to perform query")
        }
        
        let selectStatement = try prepareStatement(sqlStatement: statementHolder, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(selectStatement)
        }
        
        var queryArray = [[String: Any]]()
        
        while sqlite3_step(selectStatement) == SQLITE_ROW {
            queryArray.append([String : Any]())
            
            for (index, alias) in statement.getColumnAliases()!.enumerated() {
                let columnName = statement.getColumnNameByAlias(columnAlias: alias)!
                
                guard let table = statement.getTableByColumnName(columnName: columnName) else {
                    throw SQLiteError.Query(message: "Unable to access stored table during querry")
                }
                
                switch table.getColumnData(columnName: columnName)!.dataType {
                case .CHAR:
                    let tempText = String(cString: sqlite3_column_text(selectStatement, Int32(index)))
                    queryArray[queryArray.count - 1][alias] = tempText
                case .INT, .INTEGER:
                    let tempInt = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    queryArray[queryArray.count - 1][alias] = tempInt
                case .BOOL:
                    let tempBool = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    queryArray[queryArray.count - 1][alias] = tempBool == 1 ? true : false
                default:
                    break
                }
            }
        }
        
        if queryArray.count == 0 {
            return nil
        }
        
        return queryArray
    }
}
