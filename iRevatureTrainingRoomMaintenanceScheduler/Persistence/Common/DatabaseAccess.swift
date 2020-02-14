//
//  DatabaseAccess.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3
import os.log

class DatabaseAccess {
    
    private let dbPointer: OpaquePointer?
    
    //Initialize DB
    private init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }

    //Deinitialize DB
    deinit {
        sqlite3_close(dbPointer)
    }
    
    public func getDBPointer() -> OpaquePointer? {
        return dbPointer
    }
    
//===============================================================================================
    //Open Database
//===============================================================================================
    static func openDatabase(path: String?) throws -> DatabaseAccess! {
        //Create a reference pointer to hold access to file
        var db: OpaquePointer?
        
        //Close connection if database connection failed
        defer {
            if db != nil {
                sqlite3_close(db)
            }
        }
        
        //Attempt to open the databse file
        //Return database if found or return nil otherwise
        if sqlite3_open(path, &db) == SQLITE_OK {
            return DatabaseAccess(dbPointer: db)
        }
        else {
            os_log(SQLiteErrorMessage.openDatabaseError, log: OSLog.default, type: .error)
            throw SQLiteError.OpenDatabase(message: SQLiteErrorMessage.openDatabaseError)
        }
    }
}
