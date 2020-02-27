//
//  RoomTaskCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension RoomTaskTable {
    
    static func getTasksByRoom(roomID: Int) -> [RoomTask]? {
        guard let result = Database.execute(selectStatement: getTaskByRoomStatement(roomID: roomID), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else { return nil }
        
        return resultStruct
    }
    
    static func insert(roomID: Int, roomTaskID: Int) -> Bool {
        if !Database.execute(insertStatement: insertStatement(roomTaskApiID: "", dateStart: "", dateEnd: "", roomID: roomID, roomTaskID: roomTaskID), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func getRoomTasksByDate(databaseName: String, roomID: Int, date: Date) -> [(roomTaskID: Int, taskID: Int, taskName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        let selectStatement = RoomTaskTable.getTasksByDate(roomID: roomID, date: date)
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var roomTaskArray = [(roomTaskID: Int, taskID: Int, taskName: String)]()

            for row in result {
                var roomTask = (roomTaskID: Int(), taskID: Int(), taskName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case RoomTaskTable.ColumnName.id.rawValue:
                        roomTask.roomTaskID = value as! Int
                    case RoomTaskTable.ColumnName.taskID.rawValue:
                        roomTask.taskID = value as! Int
                    case TaskTable.ColumnName.name.rawValue:
                        roomTask.taskName = value as! String
                    default:
                        return nil
                    }
                }

                roomTaskArray.append(roomTask)
            }

            return roomTaskArray
        } catch {
            
        }
        
        return nil
        
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [RoomTask]? {
        if result.isEmpty {
            return nil
        }
        
        var roomTaskArray = [RoomTask]()
        
        for row in result {
            var roomTask = RoomTask()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    roomTask.id = value as! Int
                case ColumnName.apiID.rawValue:
                    roomTask.apiID = value as! String
                case ColumnName.dateStart.rawValue:
                    roomTask.dateStart = value as! String
                case ColumnName.dateStart.rawValue:
                    roomTask.dateEnd = value as! String
                case ColumnName.dateStart.rawValue:
                    roomTask.roomID = value as! Int
                case ColumnName.taskID.rawValue:
                    roomTask.taskID = value as! Int
                default:
                    return nil
                }
            }
            
            roomTaskArray.append(roomTask)
        }

        return roomTaskArray
    }
}
