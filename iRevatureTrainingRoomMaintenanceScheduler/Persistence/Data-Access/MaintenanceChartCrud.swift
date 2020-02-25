//
//  MaintenanceChartCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension MaintenanceChartTable {
    static func getMaintenanceChartRange(databaseName: String, roomID: Int, startDate: Date, endDate: Date) -> [(maintenanceChartID: Int, maintenanceChartDate: Date, maintenanceChartCleaned: Bool)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        let selectStatement = MaintenanceChartTable.getMaintenanceChartRangeStatement(roomID: roomID, startDate: startDate, endDate: endDate)
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var maintenanceChartArray = [(maintenanceChartID: Int, maintenanceChartDate: Date, maintenanceChartCleaned: Bool)]()

            for row in result {
                var maintenanceChart = (maintenanceChartID: Int(), maintenanceChartDate: Date(), maintenanceChartCleaned: Bool())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        maintenanceChart.maintenanceChartID = value as! Int
                    case "date":
                        let dateString = value as! String
                        
                        guard let chartDate = SQLiteDateFormat.dateFormatter.date(from: dateString) else {
                            print("failed in date")
                            return nil
                        }
                        
                        maintenanceChart.maintenanceChartDate = chartDate
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
            print(error)
        }
        
        return nil
        
    }
}
