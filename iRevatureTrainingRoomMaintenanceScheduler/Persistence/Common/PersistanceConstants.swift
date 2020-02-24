//
//  Constants.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

struct DatabaseInfo {
    static let databaseName: String = "test"
    static let databaseDirectory: FileManager.SearchPathDirectory = .documentDirectory
    static let databaseDomainMask: FileManager.SearchPathDomainMask = .userDomainMask
}

struct SQLiteDateFormat {
    static var dateFormatter: DateFormatter {
        let sqliteDateFormat = DateFormatter()
        sqliteDateFormat.dateFormat = "yyyy-MM-dd"
        return sqliteDateFormat
    }
}
