//
//  DelegateTaskBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class DelegateTaskBusinessService: DelegateTaskProtocol {
    
    static func createNewTaskDelegation(room: String, date: Date, trainer: String) {
        //code create new TaskDelegation
        
        //test
        print("Room: \(room)")
        print("Date: \(date)")
        print("Trainer: \(trainer)")
    }
    
}
