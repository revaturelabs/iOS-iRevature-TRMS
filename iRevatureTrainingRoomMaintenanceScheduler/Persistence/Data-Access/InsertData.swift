//
//  InsertData.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

class SQLiteInsertData {
    
    static func insertCampus(databaseName: String, name: String) -> Bool{
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return false
        }
        
        let insertStatement = InsertStatement(table: CampusTable.table, columnValues: 0, name)
        
        do {
            try db.insertRow(statement: insertStatement)
        } catch {
            return false
        }
        
        return true
    }
    
    static func insertTask(databaseName: String, name: String) -> Bool{
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return false
        }
        
        let insertStatement = InsertStatement(table: TaskTable.table, columnValues: 0, name)
        
        do {
            try db.insertRow(statement: insertStatement)
        } catch {
            return false
        }
        
        return true
    }
}
