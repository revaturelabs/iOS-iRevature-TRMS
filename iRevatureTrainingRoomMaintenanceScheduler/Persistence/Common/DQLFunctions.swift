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
    func selectData(table: SQLTable.Type, columnNames: [String], at: [String: (SQLiteStatement, Any, SQLiteExpression)]?) throws -> [[String: Any]]? {
        
        var idString = ""
        var atString = ""
        
        for (index, s) in columnNames.enumerated() {
            idString += s
            
            if index < columnNames.count - 1 {
                idString += ", "
            }
        }
        
        if at != nil {
            atString = try SQLUtility.makeWhereStatement(table: table, at: at!)
        }
        
        let statement = "\(SQLiteKeyword.SELECT) \(idString) \(SQLiteKeyword.FROM) \(table) \(atString);"
        let selectStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(selectStatement)
        }
        
        var queryArray = [[String: Any]]()
        
        while sqlite3_step(selectStatement) == SQLITE_ROW {
            queryArray.append([String : Any]())
            
            for (index, s) in columnNames.enumerated() {
                switch table.columns[s]?.dataType {
                case .CHAR:
                    let tempText = String(cString: sqlite3_column_text(selectStatement, Int32(index))) as NSString
                    queryArray[queryArray.count - 1][s] = tempText
                case .INT:
                    queryArray[queryArray.count - 1][s] = Int(sqlite3_column_int(selectStatement, Int32(index))) as NSInteger
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
