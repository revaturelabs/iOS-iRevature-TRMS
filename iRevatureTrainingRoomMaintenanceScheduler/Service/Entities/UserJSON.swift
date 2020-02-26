//
//  User.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

//Structure for holding the Login JSON Response
struct UserJSON: Codable {
    let primaryLocation: String
    let statusCode: Int
    let description: String
    let loginToken: String
    let currentSystemRole:CurrentSystemRole
    let emp_id: String
    
}
//Structure for holding the child sub-type of User structure above
struct CurrentSystemRole: Codable {
    let id: Int
    let code: String
    let description: String
    let name: String
}
