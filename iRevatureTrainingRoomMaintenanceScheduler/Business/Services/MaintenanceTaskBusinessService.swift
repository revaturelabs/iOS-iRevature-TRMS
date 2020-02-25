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
        
        chartID = getChartID(room: room, date: date, isCompleted: roomCompleted)
        
//
//        if let chart = MaintenanceChartTable.getByDate(roomID: room.id, date: date) {
//            chartID = chart.maintenanceChartID
//            MaintenanceChartTable.update(maintenanceChartID: chart.maintenanceChartID, completed: roomCompleted, inspectedByID: nil)
//        } else {
//            guard let idHolder = MaintenanceChartTable.insert(roomID: room.id, assignedUserID: 1, completed: roomCompleted) else { return false }
//
//            chartID = idHolder
//        }
//
        if MaintenanceChartTaskTable.getByMaintenanceChart(maintenanceChartID: chartID) == nil {
            for task in taskList {
                MaintenanceChartTaskTable.insert(maintenanceChartID: chartID, taskID: task.id, taskCompleted: task.completed)
            }
        } else {
            for task in taskList {
                MaintenanceChartTaskTable.update(maintenanceChartID: chartID, taskID: task.id, completed: task.completed)
            }
        }
        
        
        return true
    }
    
    
    static func getAllMaintenanceTasks() -> [MaintenanceTask] {
        //code to get array of MaintenanceTasks
        return []
    }
    
    
    static func getAllMaintenanceTasksByRoom(room: RoomName) -> [MaintenanceTask] {
        //get maintechartid by room, then get maintenance tasks
        guard let tasks = RoomTaskTable.getRoomTasksByDate(databaseName: DatabaseInfo.databaseName, roomID: room.id, date: Date()) else {
            return []
        }
        return tasks.map{MaintenanceTask(id: $0.roomTaskID, name: $0.taskName, completed: false)}
    }
    
    private static func getChartID(room: RoomName, date: Date, isCompleted: Bool) -> Int {
        var id: Int
        if let chart = MaintenanceChartTable.getByDate(roomID: room.id, date: date) {
            id = chart.maintenanceChartID
            MaintenanceChartTable.update(maintenanceChartID: chart.maintenanceChartID, completed: isCompleted, inspectedByID: nil)
        } else {
            guard let idHolder = MaintenanceChartTable.insert(roomID: room.id, assignedUserID: 1, completed: isCompleted) else { return -1 }
            
            id = idHolder
        }
        return id
    }
    
}
