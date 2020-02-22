//
//  OpenDatabase.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

class Database {
    
    static func getDatabase(databaseName: String) -> DatabaseAccess? {
        let fileName = DatabaseAccess.getDatabaseFilePath(name: databaseName, pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        return DatabaseAccess.openDatabase(path: fileName, createIfDoesNotExist: false)
    }
}
