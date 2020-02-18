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
    func selectSingleTable(select: SelectStatement) throws -> [[String: Any]]? {
        
        var idString = ""
        var atString = ""
        
        
        //Compile Table IDs
        idString = SQLStatement.makeIDStatement(columnNames: select.columnNames)
        
        //Compile where statement
        if let at = select.whereAt {
            atString = try SQLStatement.makeWhereStatement(table: select.table, at: at)
        }
        
        //Prepare full SQL string
        let statement = "\(SQLiteKeyword.SELECT) \(idString) \(SQLiteKeyword.FROM) \(select.table) \(atString);"
        let selectStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
        
        defer {
            sqlite3_finalize(selectStatement)
        }
        
        var queryArray = [[String: Any]]()
        
        while sqlite3_step(selectStatement) == SQLITE_ROW {
            queryArray.append([String : Any]())
            
            for (index, s) in select.columnNames!.enumerated() {
                switch select.table.columns[s]?.dataType {
                case .CHAR:
                    let tempText = String(cString: sqlite3_column_text(selectStatement, Int32(index)))
                    queryArray[queryArray.count - 1][s] = tempText
                case .INT:
                    let tempInt = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    queryArray[queryArray.count - 1][s] = tempInt
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
    
//===============================================================================================
    //Select Data From Table
//===============================================================================================
    func selectJoinTable (table: [(joinType: SQLiteJoin, String, String, SQLTable.Type)], values: [String] ) {
        
    }
    
}
