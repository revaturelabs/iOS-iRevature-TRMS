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
        //code to get all rooms from persistence layer
        guard let rooms = RoomTable.getAll(databaseName: DatabaseInfo.databaseName) else {
            return []
        }
        //dummy rooms
//        var rooms = [Room]()
//        for i in 1...10 {
//            let room = Room(id: i, name: "Room \(i)", campus: "USF", location: "USF", assignedTo: "Uday", assignedTasks: task)
//            rooms.append(room)
//        }

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
        var roomNames = [String]()
        for room in allRooms {
            roomNames.append(room.name)
        }
        return roomNames
    }
    
}
