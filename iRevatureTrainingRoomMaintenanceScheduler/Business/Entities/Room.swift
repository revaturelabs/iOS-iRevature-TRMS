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
    var assignedTo: String
    var assignedTasks: [RoomTask]
}
