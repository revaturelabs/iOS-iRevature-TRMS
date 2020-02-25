//
//  RoomBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class RoomBusinessService: RoomProtocol {

    //dummy task to build rooms
    static let task = [RoomTask(id: 1, name: "Clean Room", dateStart: Date(timeIntervalSinceNow: -100000), dateEnd: Date(timeIntervalSinceNow: 100000))]
    
    static func getAllRooms() -> [RoomName] {

        guard let rooms = RoomTable.getAll(databaseName: DatabaseInfo.databaseName) else {
            return [RoomName(id: 0, name: "No rooms available")]
        }
        return rooms.map{RoomName(id: $0.roomID, name: $0.roomName)}
    }
    
    static func getRoomsByUser(user: User) -> [Room] {
        //code to get all rooms assigned to a user
        
        //dummy rooms
        let rooms = [Room(id:1, name: "Room", campus: "USF", location: "USF", assignedTo: "Uday", assignedTasks: task)]
        
        return rooms
    }
    
    static func getAllRoomNames() -> [String] {
        let allRooms = getAllRooms()
        return allRooms.map{$0.name}
    }
    
}
