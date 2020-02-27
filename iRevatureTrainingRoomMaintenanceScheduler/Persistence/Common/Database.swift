//
//  OpenDatabase.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import os.log

class Database {
    
    static func getDatabase(databaseName: String) -> DatabaseAccess? {
        let fileName = DatabaseAccess.getDatabaseFilePath(name: databaseName, pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        return DatabaseAccess.openDatabase(path: fileName, createIfDoesNotExist: false)
    }
    
//================================
    //Run Select Statement
//================================
    static func execute(selectStatement statement: SelectStatement, fromDatabase databaseName: String) -> [[String : Any]]? {
        guard let db = getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        do {
            return try db.selectData(statement: statement)
            
        } catch {
            os_log("%s", log: OSLog.default, type: .error, error.localizedDescription)
            return nil
        }
        
    }

//================================
    //Run Insert Statement
//================================
    static func execute(insertStatement statement: InsertStatement, fromDatabase databaseName: String) -> Bool {
        guard let db = getDatabase(databaseName: databaseName) else {
            return false
        }
        
        do {
            try db.insertRow(statement: statement)
            return true
        } catch {
            os_log("%s", log: OSLog.default, type: .error, error.localizedDescription)
            return false
        }
        
    }

//================================
    //Run Update Statement
//================================
    static func execute(updateStatement statement: UpdateStatement, fromDatabase databaseName: String) -> Bool {
        guard let db = getDatabase(databaseName: databaseName) else {
            return false
        }
        
        do {
            try db.updateRow(statement: statement)
            return true
        } catch {
            os_log("%s", log: OSLog.default, type: .error, error.localizedDescription)
            return false
        }
        
    }

//================================
    //Run Delete Statement
//================================
    static func execute(deleteStatement statement: DeleteStatement, fromDatabase databaseName: String) -> Bool {
        guard let db = getDatabase(databaseName: databaseName) else {
            return false
        }
        
        do {
            try db.deleteRow(statement: statement)
            return true
        } catch {
            os_log("%s", log: OSLog.default, type: .error, error.localizedDescription)
            return false
        }
        
    }
    
//================================
    //Run Drop Statement
//================================
    static func execute(tableToDrop: SQLiteTable, fromDatabase databaseName: String) -> Bool {
        guard let db = getDatabase(databaseName: databaseName) else {
            return false
        }
        
        do {
            try db.dropTable(table: tableToDrop)
            //print("Dropped Table: \(table.getTableName())")
            return true
        } catch {
            //print("Failed to drop \(table.getTableName())")
            return false
        }
        
    }
}
