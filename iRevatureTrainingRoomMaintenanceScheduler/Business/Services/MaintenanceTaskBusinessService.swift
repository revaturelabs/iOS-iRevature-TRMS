//
//  MaintenanceTaskBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class MaintenanceTaskBusinessService: MaintenanceTaskProtocol {
    
    static func createMaintenanceTask(room: String, date: Date, taskList: [MaintenanceTask]) {
        //code to update MaintenanceTasks
        print("\(room) status for \(date)")
        for task in taskList {
            print("\(task.name): \(task.completed)")
        }
    }
    
    
    static func getAllMaintenanceTasks() -> [MaintenanceTask] {
        //code to get array of MaintenanceTasks
        return []
    }
    
    static func getAllMaintenanceTasksByRoom(room: RoomName) -> [MaintenanceTask] {
        guard let tasks = RoomTaskTable.getRoomTasksByDate(databaseName: DatabaseInfo.databaseName, roomID: room.id, date: Date()) else {
            return []
        }
        return tasks.map{MaintenanceTask(id: $0.roomTaskID, name: $0.taskName, completed: false)}
    }
    
}
