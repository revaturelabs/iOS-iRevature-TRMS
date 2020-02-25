//
//  MaintenanceTaskBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class MaintenanceTaskBusinessService: MaintenanceTaskProtocol {
    
    static func createMaintenanceTask(room: RoomName, date: Date, taskList: [MaintenanceTask]) -> Bool {
        
        var chartID: Int
        var roomCompleted = true
        
        for task in taskList {
            if !task.completed {
                roomCompleted = false
                break
            }
        }
        
        
        if let chart = MaintenanceChartTable.getByDate(roomID: room.id, date: date) {
            chartID = chart.maintenanceChartID
            MaintenanceChartTable.update(maintenanceChartID: chart.maintenanceChartID, completed: roomCompleted, inspectedByID: nil)
        } else {
            guard let idHolder = MaintenanceChartTable.insert(roomID: room.id, assignedUserID: 1, completed: roomCompleted) else { return false }
            
            chartID = idHolder
        }
        
        for task in taskList {
            MaintenanceChartTaskTable.insert(maintenanceChartID: chartID, taskID: task.id, taskCompleted: task.completed)
        }
//
//        if let maintenanceChartID = MaintenanceChartTable.insert(roomID: room.id, assignedUserID: 1, completed: false) {
//
//            guard MaintenanceChartTable.update(maintenanceChartID: maintenanceChartID, completed: nil, inspectedByID: nil) else {
//                return
//            }
//        }
//
//
//        print("\(room) status for \(date)")
//        for task in taskList {
//            print("\(task.name): \(task.completed)")
//        }
        return true
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
