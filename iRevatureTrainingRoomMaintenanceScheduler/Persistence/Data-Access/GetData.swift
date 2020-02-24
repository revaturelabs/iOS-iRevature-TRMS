//
//  GetData.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class SQLiteProcedures {
    
    static func getAllTrainers(databaseName: String) -> [(trainerId: Int, trainerName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.name.rawValue, asName: "name")
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var trainerArray = [(trainerId: Int, trainerName: String)]()

            for row in result {
                var trainer = (trainerId: Int(), trainerName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        trainer.trainerId = value as! Int
                    case "name":
                        trainer.trainerName = value as! String
                    default:
                        return nil
                    }
                }

                trainerArray.append(trainer)
            }

            return trainerArray
        } catch {
            
        }
        
        return nil
        
    }
    
    static func getMaintenanceChartRange(databaseName: String, roomID: Int, startDate: Date, endDate: Date) -> [(maintenanceChartID: Int, maintenanceChartDate: String, maintenanceChartCleaned: Bool)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        let selectStatement = MaintenanceChartTable.getMaintenanceChartRangeStatement(roomID: roomID, startDate: startDate, endDate: endDate)
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var maintenanceChartArray = [(maintenanceChartID: Int, maintenanceChartDate: String, maintenanceChartCleaned: Bool)]()

            for row in result {
                var maintenanceChart = (maintenanceChartID: Int(), maintenanceChartDate: String(), maintenanceChartCleaned: Bool())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        maintenanceChart.maintenanceChartID = value as! Int
                    case "date":
                        maintenanceChart.maintenanceChartDate = value as! String
                    case "cleaned":
                        maintenanceChart.maintenanceChartCleaned = value as! Bool
                    default:
                        return nil
                    }
                }

                maintenanceChartArray.append(maintenanceChart)
            }

            return maintenanceChartArray
        } catch {
            
        }
        
        return nil
        
    }
    
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
                    case "room_task_id":
                        roomTask.roomTaskID = value as! Int
                    case "task_id":
                        roomTask.taskID = value as! Int
                    case "task_name":
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
        
        return nil
        
    }
    
}
