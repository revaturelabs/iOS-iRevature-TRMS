//
//  DatabaseAccess.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3

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
    //Open database at given path location or create one
    static func openDatabase(path: String?, createIfDoesNotExist: Bool) -> DatabaseAccess? {
        //Create a reference pointer to hold access to file
        var db: OpaquePointer?
        
        //Attempt to open the databse file
        if createIfDoesNotExist {
            if sqlite3_open(path, &db) == SQLITE_OK {
                return DatabaseAccess(dbPointer: db)
            }
            else {
                //Close connection if database connection failed
                defer {
                    if db != nil {
                        sqlite3_close(db)
                    }
                }
                
                return nil
            }
        }
        else {
            if sqlite3_open_v2(path, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK {
                return DatabaseAccess(dbPointer: db)
            }
            else {
                //Close connection if database connection failed
                defer {
                    if db != nil {
                        sqlite3_close(db)
                    }
                }
                return nil
            }
        }
        
    }

//===============================================================================================
    //Open Database
//===============================================================================================
    //Get the file path for a database
    static func getDatabaseFilePath(name: String, pathDirectory: FileManager.SearchPathDirectory, domainMask: FileManager.SearchPathDomainMask) -> String? {
        var filePath:String?

        if let dir = FileManager.default.urls(for: pathDirectory, in: domainMask).first{
            filePath = dir.appendingPathComponent(name + ".db").absoluteString

            return filePath!
        }

        return nil
    }
}
