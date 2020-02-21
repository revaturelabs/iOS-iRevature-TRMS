//
//  Protocols.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

protocol SQLiteStatement {
    func makeStatement() -> String?
}
