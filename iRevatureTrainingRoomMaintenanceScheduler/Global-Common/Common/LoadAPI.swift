//
//  LoadAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/27/20.
//  Copyright © 2020 revature. All rights reserved.
//

class LoadAPI {
    static func runScript() {
        DropAllTables.runScript()
        CreateAllTables.runScript()
        InsertDataIntoTables.runScript()
    }
}
