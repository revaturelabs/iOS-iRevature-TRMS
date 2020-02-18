//
//  User.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/12/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var email: String
    var name: String
    var role: String
    var token: String?
    var keepLoggedIn: Bool
}
