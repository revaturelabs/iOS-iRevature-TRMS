//
//  TrainerJSON.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct APITrainerResponse {
    var statusCode: Int
    var description: String
    var trainers: [JSONTrainer]
}

struct JSONTrainer {
    var id: String
    var name: String
    var emailaddress: String
    var primarylocation: String
    var profilepicture: String
    var skills: [String]
}
