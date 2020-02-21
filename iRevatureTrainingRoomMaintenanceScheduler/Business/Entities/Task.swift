//
//  Task.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/12/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct MaintenanceTask {
    var id: Int
    var name: String
    var completed: Bool
}


struct RoomTask {
    var id: Int
    var name: String
    var dateStart: Date
    var dateEnd: Date
}


struct TaskDelegation {
    var room: String
    var currentDate: Date
    var endDate: Date
    var trainer: Trainer
}
