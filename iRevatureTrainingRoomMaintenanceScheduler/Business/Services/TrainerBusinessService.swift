//
//  TrainerBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class TrainerBusinessService: TrainerProtocol {
    
    static func getAllTrainers() -> [User] {
        //code to get all trainers
        return [User(id: 1, email: "a@a.a", name: "A", role: "", keepLoggedIn: false)]
    }
    
    static func getAllTrainerNames() -> [String] {
        //code to get trainer names
        return ["Uday", "Nick", "Mayur"]
    }
    
    
}
