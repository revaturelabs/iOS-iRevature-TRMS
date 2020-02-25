//
//  ReportBusinessServices.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class ReportBusinessService : ReportProtocol {
    
    static func getAllReports(room: RoomName, fromDate:Date, toDate:Date) -> [Status] {
        //code to get all reports
        guard let reports = MaintenanceChartTable.getMaintenanceChartRange(databaseName: DatabaseInfo.databaseName, roomID: room.id, startDate: fromDate, endDate: toDate) else {
            return []
        }
        return reports.map{Status(roomName: room.name, date: $0.maintenanceChartDate, isClean: $0.maintenanceChartCleaned)}
    }
    
    
    static func getAllReportsforUser(user:User) -> [Status] {
        //code to get reports for given Trainer
        return []
    }
    
}
