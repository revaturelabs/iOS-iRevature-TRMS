//
//  RoomProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol RoomProtocol {
    
    static func getAllRooms() -> [RoomName]
    
    static func getRoomsByUser(user: User) -> [Room]
    
    static func getAllRoomNames() -> [String]
    
}
