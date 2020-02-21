//
//  TrainerBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class TrainerBusinessService: TrainerProtocol {
    
    static func getAllTrainers() -> [Trainer] {
        //code to get all trainers
        return [Trainer(id: 1,  name: "A")]
    }
    
    static func getAllTrainerNames() -> [String] {
        //code to get trainer names
        return ["Uday", "Nick", "Mayur"]
    }
    
    
}
