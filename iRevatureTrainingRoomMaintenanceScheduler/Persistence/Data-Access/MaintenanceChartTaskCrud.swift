//
//  MaintenanceChartTaskCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension MaintenanceChartTaskTable {
    
    static func getByMaintenanceChart(maintenanceChartID: Int) -> [MaintenanceChartTask]? {
        guard let result = Database.execute(selectStatement: getByMaintenanceChartIDStatement(maintenanceChartID: maintenanceChartID), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else {
            return nil
        }
        
        return resultStruct
    }
    
    static func insert(maintenanceChartID: Int, taskID: Int, taskCompleted: Bool) -> Bool {
        if !Database.execute(insertStatement: MaintenanceChartTaskTable.insertStatement(maintencanceChartID: maintenanceChartID, taskID: taskID, completed: taskCompleted), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func update(maintenanceChartID: Int, taskID: Int, completed: Bool) -> Bool {
        if !Database.execute(updateStatement: updateStatement(maintenanceChartID: maintenanceChartID, taskID: taskID, completed: completed), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [MaintenanceChartTask]? {
        if result.isEmpty {
            return nil
        }
        
        var maintenanceChartTaskArray = [MaintenanceChartTask]()
        
        for row in result {
            var maintenanceChartTask = MaintenanceChartTask()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    maintenanceChartTask.id = value as! Int
                case ColumnName.apiID.rawValue:
                    maintenanceChartTask.apiID = ""
                case ColumnName.maintenanceChartID.rawValue:
                    maintenanceChartTask.maintenanceChartID = value as! Int
                case ColumnName.completed.rawValue:
                    maintenanceChartTask.completed = value as! Bool
                default:
                    return nil
                }
            }
            
            maintenanceChartTaskArray.append(maintenanceChartTask)
        }

        return maintenanceChartTaskArray
    }
}
