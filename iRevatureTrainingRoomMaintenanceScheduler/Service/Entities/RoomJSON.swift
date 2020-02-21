//
//  RoomJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APIRoomResponse {
    var statusCode: Int
    var description: String
    var allcampus: [JSONCampus]
    var allrooms: [JSONRoom]
}

struct JSONCampus {
    var id: String
    var campus: String
}

struct JSONRoom {
    var id: String
    var room: String
    var capacity: Int
}
