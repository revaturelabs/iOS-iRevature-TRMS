//
//  TrainerProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol TrainerProtocol {
    
    static func getAllTrainers() -> [User]
    
    static func getAllTrainerNames() -> [String]
    
}
