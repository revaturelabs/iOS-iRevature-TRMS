//
//  Statement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct SelectSingleTableStatement {
    var table: SQLiteTable
    var columnNames: [String]?
    var whereAt: [String : WhereStatement]?
}



struct SelectJoinTableStatement {
    var joinInfo: JoinSelectInfo
    var whereAt: [String : WhereStatement]?
}

struct JoinSelectInfo {
    var joinType: SQLiteJoin
    var table: SQLiteTable
    var ColumnNames: [SelectAlias]
}

struct SelectAlias {
    var columnName: String
    var asName: String?
}


