//
//  Room.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/12/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct Room {
    var id: Int
    var name: String
    var campus: String
    var location: String
    var assignedTo: String  //Should this be User instead of String?
    var assignedTasks: [RoomTask]
}


struct RoomName: Codable {
    var id: Int
    var name: String
}


struct RoomStatus {
    var roomName: String
    var date: Date
    var isClean: Bool
}


struct RoomCheckList {
    var roomName: String
    var tasks: [MaintenanceTask]
}
