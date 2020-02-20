//
//  MaintenanceTaskBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class MaintenanceTaskBusinessService: MaintenanceTaskProtocol {
    
    static func getAllMaitenanceTasks() -> [MaintenanceTask] {
        //code to get array of MaintenanceTasks
        
        //dummy data
        let tasks = [
            MaintenanceTask(id: 1, name: "Clean Desks", completed: false),
            MaintenanceTask(id: 1, name: "Clean Whiteboards", completed: false),
            MaintenanceTask(id: 1, name: "Arrange Desks", completed: false),
            MaintenanceTask(id: 1, name: "Arrange Chairs", completed: false),
            MaintenanceTask(id: 1, name: "Vacuum", completed: false)
        ]
        
        return tasks
    }
    
}
