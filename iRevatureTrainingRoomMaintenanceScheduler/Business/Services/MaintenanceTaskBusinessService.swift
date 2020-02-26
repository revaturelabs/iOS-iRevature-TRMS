//
//  MaintenanceTaskBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class MaintenanceTaskBusinessService: MaintenanceTaskProtocol {
    
    static func createMaintenanceTask(room: RoomName, date: Date, taskList: [TodayTask]) -> Bool {
        
        for task in taskList {
            MaintenanceChartTaskTable.update(maintenanceChartID: task.chartId, taskID: task.id, completed: task.completed)
        }
        
        return true
    }
    
    
    static func getAllMaintenanceTasks() -> [MaintenanceTask] {
        //code to get array of MaintenanceTasks
        return []
    }
    
    
    static func getAllMaintenanceTasksByRoom(room: RoomName) -> [MaintenanceTask] {
        guard let roomTasks = RoomTaskTable.getRoomTasksByDate(databaseName: DatabaseInfo.databaseName, roomID: room.id, date: Date()) else {
            return []
        }
        return roomTasks.map{MaintenanceTask(id: $0.roomTaskID, name: $0.taskName, completed: false)}
    }
    
    
    static func getAllTasksForDay() -> [TodayTask] {
        var allTasks = [TodayTask]()
        
        let rooms = RoomBusinessService.getAllRooms()
        
        for room in rooms {
            
            let chartID = self.getChartID(room: room, date: Date(), isCompleted: false)
            
            if let roomTasks = RoomTaskTable.getRoomTasksByDate(databaseName: DatabaseInfo.databaseName, roomID: room.id, date: Date()) {

                if let chartTasks = MaintenanceChartTaskTable.getByMaintenanceChart(maintenanceChartID: chartID) {
                    for task in chartTasks {
                        let taskItem = TaskTable.getByID(taskID: task.taskID)
                        allTasks.append(TodayTask(id: task.taskID, name: taskItem!.name, room: room, chartId: task.maintenanceChartID, completed: task.completed))
                    }
                } else {
                    for task in roomTasks {
                        MaintenanceChartTaskTable.insert(maintenanceChartID: chartID, taskID: task.roomTaskID, taskCompleted: false)
                        allTasks.append(TodayTask(id: task.taskID, name: task.taskName, room: room, chartId: chartID, completed: false))
                    }
                }
                
                
            }
   
        }

        return allTasks
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
