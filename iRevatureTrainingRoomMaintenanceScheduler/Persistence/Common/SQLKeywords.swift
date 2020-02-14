//
//  SQLKeywords.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

enum SQLiteKeyword: String {
    case CREATE
    case TABLE
    case INSERT
    case INTO
    case WHERE
    case SET
    case VALUES
}

enum SQLiteDataType: String {
    case INT
    case CHAR
}

enum SQLiteConstraints: String {
    case PRIMARYKEY = "PRIMARY KEY"
    case NOTNULL = "NOT NULL"
}
