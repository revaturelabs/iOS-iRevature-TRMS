//
//  LocationJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/27/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APILocationResponse: Codable {
    var statusCode: Int
    var description: String
    var alllocation: [JSONLocation]
}

struct JSONLocation: Codable {
    var id: String
    var state: String
    var campus: String
    var building: String
}
