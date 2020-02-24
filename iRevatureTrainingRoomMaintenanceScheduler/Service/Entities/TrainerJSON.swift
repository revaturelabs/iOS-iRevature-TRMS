//
//  TrainerJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APITrainerResponse: Codable {
    var statusCode: Int
    var description: String
    var trainers: [JSONTrainer]
}

struct JSONTrainer: Codable {
    var id: String
    var name: String
    var emailaddress: String
    var primarylocation: String
    var profilepicture: String
    var skills: [String]
}
