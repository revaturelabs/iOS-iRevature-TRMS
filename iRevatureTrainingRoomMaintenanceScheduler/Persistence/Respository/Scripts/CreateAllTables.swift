//
//  CreateTables.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

class CreateAllTables {
    private init() {
    }
    
    static func runScript() {
        let filePath = DatabaseAccess.getDatabaseFilePath(name: DatabaseInfo.databaseName, pathDirectory: DatabaseInfo.databaseDirectory, domainMask: DatabaseInfo.databaseDomainMask)
        
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
        
        if let db = db {
            for table in SQLTable.tables {
                createTable(database: db, table: table)
            }
        }
        
    }
    
    private static func createTable(database: DatabaseAccess, table: SQLiteTable) {
        do {
            try database.createTable(table: table)
            print("Created Table: \(table.getTableName())")
        } catch {
            print("Failed to create \(table.getTableName())")
        }
    }
}
