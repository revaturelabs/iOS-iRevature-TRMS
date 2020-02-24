//
//  TaskJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APITaskResponse: Codable {
    var statusCode: Int
    var description: String
    var tasks: [JSONTask]
}

struct JSONTask: Codable {
    var id: String
    var name: String
}
