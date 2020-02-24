//
//  RoomJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APIRoomResponse: Codable {
    var statusCode: Int
    var description: String
    var allcampus: [JSONCampus]
    var allrooms: [JSONRoom]
}

struct JSONCampus: Codable {
    var id: String
    var campus: String
}

struct JSONRoom: Codable {
    var id: String
    var room: String
    var capacity: Int
}
