//
//  SQLError.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import SQLite3

//Used for throwing errors
enum SQLiteError: Error {
    case OpenDatabase(message: StaticString)
    
    case Prepare(message: String)
    case Step(message: StaticString)
    case Bind(message: StaticString)
    
    case Create(message: StaticString)
    case Insert(message: StaticString)
    case Update(message: StaticString)
    case Delete(message: StaticString)
    case Query(message: StaticString)
    case Drop(message: StaticString)
    case Truncate(message: StaticString)
}

//Strings for specific errors
struct SQLiteErrorMessage {
    static let openDatabaseError: StaticString = "Error while opening database"
    
    static let prepareStatementError: StaticString = "Error during prepared execution"
    static let tableCreationError: StaticString = "Error during table creation"
    static let tableInsertionError: StaticString = "Error during table insertion"
    static let tableUpdateError: StaticString = "Error during table update"
    static let tableDeleteError: StaticString = "Error during table deletion"
    
    static let queryError: StaticString = "Error during query"
    
    static let tableDropError: StaticString = "Error during table drop"
    static let tableTruncateError: StaticString = "Error during table truncate"
    
    static let noErrorExists: StaticString = "No error message provided by SQLite"
    
}

//extension DatabaseAccess {
//    //Generate an error message
//    public var errorMessage: String {
//        if let errorPointer = sqlite3_errmsg(self.getDBPointer()) {
//            let errorMessage = String(cString: errorPointer)
//            return errorMessage
//        }
//        else {
//            return SQLiteErrorMessage.noErrorExists.description
//        }
//    }
//}
