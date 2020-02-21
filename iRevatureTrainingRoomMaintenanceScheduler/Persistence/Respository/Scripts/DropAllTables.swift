//
//  DropAllTables.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

class DropAllTables {
    private init() {
    }
    
    static func runScript() {
        let filePath = DatabaseAccess.getDatabaseFilePath(name: DatabaseInfo.databaseName, pathDirectory: DatabaseInfo.databaseDirectory, domainMask: DatabaseInfo.databaseDomainMask)
        
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
        
        if let db = db {
            for table in SQLTable.tables {
                dropTable(database: db, table: table)
            }
            
            do {
                try db.dropTable(table: SQLiteTable(tableName: "sqlite_sequence"))
            } catch {
                print("failed to drop sequence")
            }
        }
        
    }
    
    private static func dropTable(database: DatabaseAccess, table: SQLiteTable) {
        do {
            try database.dropTable(table: table)
            print("Dropped Table: \(table.getTableName())")
        } catch {
            print("Failed to drop \(table.getTableName())")
        }
    }
}
