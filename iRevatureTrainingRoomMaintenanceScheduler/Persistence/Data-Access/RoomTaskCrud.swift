//
//  RoomTaskCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension RoomTaskTable {
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
                    case RoomTable.ColumnName.id.rawValue:
                        roomTask.roomTaskID = value as! Int
                    case TaskTable.ColumnName.id.rawValue:
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
        print("fail 3")
        return nil
        
    }
}
