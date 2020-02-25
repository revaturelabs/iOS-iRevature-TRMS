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
        guard let trainerDB = UserTable.getAll(databaseName: DatabaseInfo.databaseName) else {
            return [Trainer(id: 0, name: "No Trainers Available")]
        }
        return trainerDB.map{Trainer(id: $0.trainerId, name: $0.trainerName)}
    }
    
    static func getAllTrainerNames() -> [String] {
        let trainers = getAllTrainers()
        return trainers.map{$0.name}
    }
    
    
}
