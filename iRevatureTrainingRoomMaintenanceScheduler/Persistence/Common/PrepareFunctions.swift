//
//  DatabaseFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3
import os.log



enum Statement {
    
    case prepare
    case prepare_v2
    //case prepare_v3
    case prepare16
    case prepare16_v2
    //case prepare16_v3
    
    
    func makeStatement(database: OpaquePointer, sqlStatement: String) throws -> OpaquePointer? {
        
        switch self {
        case .prepare:
            let statement = try prepareV1 (dbPointer: database, sql: sqlStatement)
            return statement
        case .prepare_v2:
            let statement = try prepareV2(dbPointer: database, sql: sqlStatement)
            return statement
        case .prepare16:
            let statement = try prepare16V1(dbPointer: database, sql: sqlStatement)
            return statement
        case .prepare16_v2:
            let statement = try prepare16V2(dbPointer: database, sql: sqlStatement)
            return statement
        }
    }
    
//===============================================================================================
    //Prepare Functions
//===============================================================================================
    private func prepareV1(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            os_log("Error during prepared execution", log: OSLog.default, type: .error)
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepareV2(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            os_log("Error during prepared execution", log: OSLog.default, type: .error)
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepare16V1(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare16(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            os_log("Error during prepared execution", log: OSLog.default, type: .error)
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepare16V2(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare16_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            os_log("Error during prepared execution", log: OSLog.default, type: .error)
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
}

extension DatabaseAccess {
    
    func prepareStatement(sqlStatement: String, statementType: Statement) throws -> OpaquePointer? {
        return try statementType.makeStatement(database: self.getDBPointer()!, sqlStatement: sqlStatement)
    }
    
    
}

class test {
    func test () {
        
        do {
            let db = try DatabaseAccess.openDatabase(path: "")
            let stmt = try db?.prepareStatement(sqlStatement: "Your Statement", statementType: .prepare_v2)
            try db?.createTable(table: TestTable.self)
        } catch {
            
        }
    }
}