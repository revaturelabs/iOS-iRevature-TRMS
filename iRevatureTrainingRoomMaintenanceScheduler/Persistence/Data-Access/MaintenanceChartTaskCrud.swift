//
//  MaintenanceChartTaskCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension MaintenanceChartTaskTable {
    static func insert(maintenanceChartID: Int, tasks: [(id: Int, completed: Bool)]) -> Bool {
        
        for task in tasks {
            if !Database.execute(insertStatement: MaintenanceChartTaskTable.insertStatement(maintencanceChartID: maintenanceChartID, taskID: task.id, completed: task.completed), fromDatabase: DatabaseInfo.databaseName) {
                return false
            }
        }
        
        return true
    }
    
    static func update(maintenanceChartID: Int, taskID: Int, completed: Bool) -> Bool {
        if !Database.execute(updateStatement: updateStatement(maintenanceChartID: maintenanceChartID, taskID: taskID, completed: completed), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
}
