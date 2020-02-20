//
//  DelegateTaskProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol DelegateTaskProtocol {
    
    static func createNewTaskDelegation(room: String, date: Date, trainer: String)
    
}
