//
//  DatabaseFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

enum PrepareStatement {
    
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
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepareV2(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepare16V1(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare16(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
    private func prepare16V2(dbPointer: OpaquePointer, sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare16_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: String(cString: sqlite3_errmsg(statement)))
        }
        
        return statement
    }
    
}

extension DatabaseAccess {
//===============================================================================================
    //Make A Prepared Statement
//===============================================================================================
    func prepareStatement(sqlStatement: String, statementType: PrepareStatement) throws -> OpaquePointer? {
        return try statementType.makeStatement(database: getDBPointer()!, sqlStatement: sqlStatement)
    }
    
    
}

