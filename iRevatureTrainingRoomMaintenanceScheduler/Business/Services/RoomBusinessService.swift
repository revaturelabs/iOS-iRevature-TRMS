//
//  RoomBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class RoomBusinessService: RoomProtocol {
    
    static func getAllRooms() -> [RoomName] {

        guard let rooms = RoomTable.getAll(databaseName: DatabaseInfo.databaseName) else {
            return [RoomName(id: 0, name: "No rooms available")]
        }
        return rooms.map{RoomName(id: $0.roomID, name: $0.roomName)}
    }
    
    static func getRoomsByUser(user: User) -> [Room] {
        //code to get all rooms assigned to a user
        return []
    }
    
    static func getAllRoomNames() -> [String] {
        let allRooms = getAllRooms()
        return allRooms.map{$0.name}
    }
    
}
