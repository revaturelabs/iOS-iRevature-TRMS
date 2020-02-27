//
//  InsertIntoTables.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//


class InsertDataIntoTables {
    static let locations = ["Tampa, FL", "Reston, VA"]
    static let campuses = ["UTA", "USF"]
    static let roomNames = ["NEC 200", "NEC 300", "NEC 320", "NEC 210"]
    static let taskNames = ["Arrange Desks", "Wipe Desks", "Clean Desks", "Clean Whiteboards", "Arrange Chairs"]
    
    
    static func runScript() {
        insertTasks()
        insertCampuses()
        insertLocations()
        insertRooms()
        insertMainenanceCharts()
        insertRoomTasks()
        
    }
    
    private static func insertTasks() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)
        
        TaskAPI().getTasks(nil, { tasks in
            
            for task in tasks {
                let insertStatement = TaskTable.insertStatement(taskApiID: task.id, taskName: task.name)
                
                do {
                    try db?.insertRow(statement: insertStatement)
                } catch {
                    print("Insert of \(task.name) task failed")
                }
            }
            
        })
    }
    
    private static func insertLocations() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)
        
        for (index, location) in locations.enumerated() {
            let insertStatement = InsertStatement(table: LocationTable.table, columnValues: index + 1, "\(index + 1)", location)
            
            do {
                try db?.insertRow(statement: insertStatement)
            } catch {
                print("Insert of \(location) location failed")
            }
        }
    }
    
    private static func insertCampuses() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)

        for (index, campus) in campuses.enumerated() {
        let insertStatement = InsertStatement(table: CampusTable.table, columnValues: index + 1, "\(index + 1)", campus)

        do {
                try db?.insertRow(statement: insertStatement)
            } catch {
                print("Insert of \(campus) location failed")
            }
        }
    }
    
    private static func insertRooms() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)

        for (index, roomName) in roomNames.enumerated() {
            let insertStatement = InsertStatement(table: RoomTable.table, columnValues: index + 1, "\(index + 1)", roomName, 1, 2, 0)
           
            do {
                try db?.insertRow(statement: insertStatement)
            } catch {
                print("Insert of \(roomName) room failed")
            }
        }
    }
    
    private static func insertMainenanceCharts() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)

        var currentIndex = 0
        
        for (index, roomName) in roomNames.enumerated() {
            for k in 0...9 {
                currentIndex += 1
                let date = "2020-02-\(String(format: "%02d", arguments: [k + 1]))"
                let roomID = index + 1
                let userID = 0
                
                let insertStatement = InsertStatement(table: MaintenanceChartTable.table, columnValues: currentIndex, "\(currentIndex)", date, Bool.random(), roomID, userID)
               
                do {
                    try db?.insertRow(statement: insertStatement)
                } catch {
                    print("Insert of \(roomName) Maintenance Chart failed")
                }
            }
        }
    }
    
    private static func insertRoomTasks() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)

        var currentIndex = 0
        
        for (index, roomName) in roomNames.enumerated() {
            for (k, _) in taskNames.enumerated() {
                currentIndex += 1
                let roomID = index + 1
                let taskID = k + 1
                
                let insertStatement = InsertStatement(table: RoomTaskTable.table, columnValues: currentIndex, "\(currentIndex)", "2020-02-01", "2020-02-28", roomID, taskID)
               
                do {
                    try db?.insertRow(statement: insertStatement)
                } catch {
                    print("Insert of \(roomName) Tasks failed")
                }
            }
        }
    }
}
