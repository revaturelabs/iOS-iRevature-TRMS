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
    case UPDATE
    case DELETE
    case INTO
    case WHERE
    case SET
    case VALUES
    case FROM
    case DROP
    case SELECT
    case AS
    case ON
}

enum SQLiteExpression: String {
    case LESSTHAN = "<"
    case GREATERTHAN = ">"
    case EQUALS = "="
    case LESSTHANEQUALS = "<="
    case GREATERTHANEQUALS = ">="
    case BETWEEN
    case IN
    case NOTIN = "NOT IN"
}

enum SQLiteClause: String {
    case AND
    case OR
    case NONE
}

enum SQLiteJoin: String {
    case INNER = "INNER JOIN"
    case OUTTER = "OUTTER JOIN"
    case CROSS = "CROSS JOIN"
}

enum SQLiteDataType: String {
    case INT
    case CHAR
    case BOOL
}

enum SQLiteConstraints: String {
    case PRIMARYKEY = "PRIMARY KEY"
    case NOTNULL = "NOT NULL"
    case UNIQUE
    case AUTOINCREMENT
}
