//
//  SQLError.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

//Used for throwing errors
enum SQLiteError: Error {
    case OpenDatabase(message: String)
    
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
    
    case Create(message: String)
    case Insert(message: String)
    case Update(message: String)
    case Delete(message: String)
    case Query(message: String)
    case Drop(message: String)
    case Truncate(message: String)
    
    case DataType(message: String)
}
