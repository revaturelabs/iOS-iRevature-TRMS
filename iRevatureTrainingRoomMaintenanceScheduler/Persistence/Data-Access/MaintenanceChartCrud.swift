//
//  MaintenanceChartCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import os.log

extension MaintenanceChartTable {
    static func getMaintenanceChartRange(databaseName: String, roomID: Int, startDate: Date, endDate: Date) -> [(maintenanceChartID: Int, maintenanceChartDate: Date, maintenanceChartCleaned: Bool)]? {
        
        let statement = getMaintenanceChartRangeStatement(roomID: roomID, startDate: startDate, endDate: endDate)
        
        guard let result = Database.execute(selectStatement: statement, fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else {
            return nil
        }
        
        var maintenanceChartArray = [(maintenanceChartID: Int, maintenanceChartDate: Date, maintenanceChartCleaned: Bool)]()
        
        //Apply struct to tuple for use else where
        for data in resultStruct {
            guard let date = SQLiteDateFormat.dateFormatter.date(from: data.date) else {
                return nil
            }
            
            maintenanceChartArray.append((maintenanceChartID: data.id, maintenanceChartDate: date, maintenanceChartCleaned: data.cleaned))
        }

        return maintenanceChartArray
        
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [MaintenanceChartTable.MaintenanceChart]? {
        
        var maintenanceChartArray = result.isEmpty ? nil : [MaintenanceChartTable.MaintenanceChart]()
        
        for row in result {
            var maintenanceChart = MaintenanceChartTable.MaintenanceChart()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    maintenanceChart.id = value as! Int
                case ColumnName.apiID.rawValue:
                    maintenanceChart.apiID = value as! String
                case ColumnName.date.rawValue:
                    maintenanceChart.date = value as! String
                case ColumnName.cleaned.rawValue:
                    maintenanceChart.cleaned = value as! Bool
                case ColumnName.roomID.rawValue:
                    maintenanceChart.roomID = value as! Int
                case ColumnName.inspectedByID.rawValue:
                    maintenanceChart.inspectedByID = value as! Int
                default:
                    return nil
                }
            }
            
            if maintenanceChartArray != nil {
                maintenanceChartArray!.append(maintenanceChart)
            }
        }

        return maintenanceChartArray
    }
}
