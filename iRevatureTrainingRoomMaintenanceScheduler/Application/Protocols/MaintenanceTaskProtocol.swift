//
//  MaintenanceTaskProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol MaintenanceTaskProtocol {
    
    static func createMaintenanceTask(room: RoomName, date:Date, taskList: [TodayTask]) -> Bool
    
    static func getAllMaintenanceTasks() -> [MaintenanceTask]
    
    static func getAllMaintenanceTasksByRoom(room: RoomName, date: Date) -> [TodayTask]
}
