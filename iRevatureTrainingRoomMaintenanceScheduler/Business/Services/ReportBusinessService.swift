//
//  ReportBusinessServices.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class ReportBusinessService : ReportProtocol {
    
    static func getAllReports() -> [Status]{
        //code to get all reports
        return[]
    }
    
    static func getAllReportsforUser(user:User) -> [Status] {
        //code to get reports for given Trainer
        
        //create dummy objects to test with
        var statusList = [Status]()
        for room in RoomBusinessService.getAllRooms() {
            statusList.append(Status(roomName: room.name, date: Date(timeIntervalSinceNow: -87000), isClean: true))
            statusList.append(Status(roomName: room.name, date: Date(timeIntervalSinceNow: -87000*2), isClean: true))
        }
        statusList.append(Status(roomName: "Room 2", date: Date(timeIntervalSinceNow: -87000*3), isClean: false))
        statusList.append(Status(roomName: "Room 8", date: Date(timeIntervalSinceNow: -87000*4), isClean: true))
        
        return statusList
    }
    
}
