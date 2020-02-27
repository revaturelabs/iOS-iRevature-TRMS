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
        
        var userID = 0
        
        if let user = UserInfoBusinessService.getUserInfo() {
            userID = user.id
        }
        
        var chartStatus = true
        
        for task in taskList {
            MaintenanceChartTaskTable.update(maintenanceChartID: task.chartId, taskID: task.id, completed: task.completed)
            if task.completed == false {
                chartStatus = false
            }
        }

        MaintenanceChartTable.update(maintenanceChartID: taskList[0].chartId, completed: chartStatus, inspectedByID: userID)
        
        
        return true
    }
    
    
    static func getAllMaintenanceTasks() -> [MaintenanceTask] {
        //code to get array of MaintenanceTasks
        return []
    }
    
    
    static func getAllMaintenanceTasksByRoom(room: RoomName, date: Date) -> [TodayTask] {
        if let chart = MaintenanceChartTable.getByDate(roomID: room.id, date: date) {
            if let chartTasks = MaintenanceChartTaskTable.getByMaintenanceChart(maintenanceChartID: chart.maintenanceChartID) {
                return chartTasks.map{TodayTask(id: $0.taskID, name: TaskTable.getByID(taskID: $0.taskID)!.name, room: room, chartId: chart.maintenanceChartID, completed: $0.completed)}
            }
        }
        return []
    }
    
    
    static func getAllTasksForDay() -> [TodayTask] {
        var allTasks = [TodayTask]()
        
        let rooms = RoomBusinessService.getAllRooms()
        
        for room in rooms {
            
            let chartID = self.getChartID(room: room, date: Date(), isCompleted: false)

            if let roomTasks = RoomTaskTable.getRoomTasksByDate(databaseName: DatabaseInfo.databaseName, roomID: room.id, date: Date()) {
                
                let chartTasks = MaintenanceChartTaskTable.getByMaintenanceChart(maintenanceChartID: chartID)

                var chartTaskHolder = chartTasks != nil ? chartTasks : nil

                if chartTaskHolder != nil {
                    for roomTask in roomTasks{
                        for (index, chartTask) in chartTaskHolder!.enumerated(){
                            if chartTask.taskID == roomTask.taskID {
                                allTasks.append(TodayTask(id: roomTask.taskID, name: roomTask.taskName, room: RoomName(id: room.id, name: room.name), chartId: chartID, completed: chartTask.completed))
                                chartTaskHolder!.remove(at: index)
                                break
                            }
                        }
                    }
                } else {
                    for roomTask in roomTasks{
                        MaintenanceChartTaskTable.insert(maintenanceChartID: chartID, taskID: roomTask.taskID, taskCompleted: false)
                        allTasks.append(TodayTask(id: roomTask.taskID, name: roomTask.taskName, room: RoomName(id: room.id, name: room.name), chartId: chartID, completed: false))
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
        } else {
            guard let idHolder = MaintenanceChartTable.insert(roomID: room.id, assignedUserID: 1, completed: isCompleted) else { return -1 }
            
            id = idHolder
        }
        return id
    }
    
}
