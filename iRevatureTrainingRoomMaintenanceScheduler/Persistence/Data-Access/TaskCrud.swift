//
//  TaskCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension TaskTable {
    static func getByID(taskID: Int) -> Task? {
        guard let result = Database.execute(selectStatement: getByIDStatement(taskID: taskID), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else {
            return nil
        }
        
        return resultStruct[0]
    }
    
    static func getByName(taskName: String) -> Task? {
        guard let result = Database.execute(selectStatement: getByNameStatement(taskName: taskName), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else {
            return nil
        }
        
        return resultStruct[0]
    }
    
    static func insert(taskApiID: String, taskName: String) -> Bool {
        if !Database.execute(insertStatement: insertStatement(taskApiID: taskApiID, taskName: taskName), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func drop() {
        if !Database.execute(tableToDrop: TaskTable.table, fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [Task]? {
        if result.isEmpty {
            return nil
        }
        
        var taskArray = [Task]()
        
        for row in result {
            var task = Task()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    task.id = value as! Int
                case ColumnName.apiID.rawValue:
                    task.apiID = value as! String
                case ColumnName.name.rawValue:
                    task.name = value as! String
                default:
                    return nil
                }
            }
            
            taskArray.append(task)
        }

        return taskArray
    }
}
