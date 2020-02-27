//
//  InsertIntoTables.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//


class InsertDataIntoTables {
    
    static func runScript() {
        insertAll()
        
    }
    
    private static func insertUsers() {
        TrainerAPI().getTrainers({users in
            
            for user in users {
                let locationID = LocationTable.getByName(databaseName: DatabaseInfo.databaseName, locationName: user.primarylocation)?.locationID ?? 0
                
                Database.execute(insertStatement: UserTable.insertStatement(userApiID: user.id, userName: user.name, userLocation: locationID), fromDatabase: DatabaseInfo.databaseName)
            }
            
        })
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
        LocationAPI().getLocation({ locations in
            for location in locations {
                LocationTable.insert(databaseName: DatabaseInfo.databaseName, apiID: location.id, locationName: location.state)
                
            }
        })
    }
    
    private static func insertRooms() {
        
        RoomAPI().getRooms({ rooms in
            for campus in rooms.allcampus {
                CampusTable.insert(campusApiID: campus.id, campusName: campus.campus)
            }
            
            for room in rooms.allrooms {
                let campusID = CampusTable.getByApiID(campusApiID: room.campus_id)?.id ?? 0
                let locationID = LocationTable.getByApiID(locationApiID: room.location_id)?.id ?? 0
                let userID = UserTable.getByApiID(userApiID: room.trainer_id)?.id ?? 0
                
                RoomTable.insert(roomApiID: room.id, roomName: room.room, roomLocationID: locationID, roomCampusID: campusID, roomUserID: userID)
            }
        })
    }
    
//    private static func insertMainenanceCharts() {
//        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)
//
//        guard let rooms = RoomTable.getAll(databaseName: DatabaseInfo.databaseName) else { return }
//        var currentIndex = 0
//        
//        for (index, roomName) in roomNames.enumerated() {
//            for k in 0...9 {
//                currentIndex += 1
//                let date = "2020-02-\(String(format: "%02d", arguments: [k + 1]))"
//                let roomID = index + 1
//                let userID = 0
//                
//                let insertStatement = InsertStatement(table: MaintenanceChartTable.table, columnValues: currentIndex, "\(currentIndex)", date, Bool.random(), roomID, userID)
//               
//                do {
//                    try db?.insertRow(statement: insertStatement)
//                } catch {
//                    print("Insert of \(roomName) Maintenance Chart failed")
//                }
//            }
//        }
//    }
    
    private static func insertRoomTasks() {
        let db = Database.getDatabase(databaseName: DatabaseInfo.databaseName)

        //var currentIndex = 0
        
        guard let rooms = RoomTable.getAll(databaseName: DatabaseInfo.databaseName) else { return }
        guard let tasks = TaskTable.getAll() else { return }
        
        for room in rooms {
            for task in tasks {
                
                
                
                let insertStatement = RoomTaskTable.insertStatement(roomTaskApiID: "", dateStart: "2020-01-01", dateEnd: "2020-12-30", roomID: room.roomID, roomTaskID: task.id)
                
                do {
                    try db?.insertRow(statement: insertStatement)
                } catch {
                    print("Insert of \(room.roomName) Tasks failed")
                }
            }
        }
    }
    
    static func insertAll() {
        LocationAPI().getLocation({ locations in
            for location in locations {
                LocationTable.insert(databaseName: DatabaseInfo.databaseName, apiID: location.id, locationName: location.state)
            }
            
            RoomAPI().getRooms({ rooms in
                for campus in rooms.allcampus {
                    CampusTable.insert(campusApiID: campus.id, campusName: campus.campus)
                }
                
                TrainerAPI().getTrainers({users in
                    
                    for user in users {
                        let locationID = LocationTable.getByName(databaseName: DatabaseInfo.databaseName, locationName: user.primarylocation)?.locationID ?? 0
                        
                        UserTable.insert(userApiID: user.id, userName: user.name, userLocation: locationID)
                    }
                    
                    for room in rooms.allrooms {
                        let campusID = CampusTable.getByApiID(campusApiID: room.campus_id)?.id ?? 0
                        let locationID = LocationTable.getByApiID(locationApiID: room.location_id)?.id ?? 0
                        let userID = UserTable.getByApiID(userApiID: room.trainer_id)?.id ?? 0
                        
                        RoomTable.insert(roomApiID: room.id, roomName: room.room, roomLocationID: locationID, roomCampusID: campusID, roomUserID: userID)
                    }
                    
                    TaskAPI().getTasks(nil, { tasks in
                        
                        for task in tasks {
                            TaskTable.insert(taskApiID: task.id, taskName: task.name)
                        }

                        insertRoomTasks()
                    })
                    
                })
                

            })
        
        })
        
    }
}
