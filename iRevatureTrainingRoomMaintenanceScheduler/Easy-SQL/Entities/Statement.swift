//
//  Statement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct SelectSingleTableStatement {
    var table: SQLTable.Type
    var columnNames: [String]?
    var whereAt: [String : WhereStatement]?
}

struct SelectMultipleTableStatement {
    var tableInfo: TableSelectInfo
    var joinAt: [JoinStatement]
}

struct TableSelectInfo {
    var table: SQLTable.Type
    var ColumnNames: [SelectAlias]
}

struct SelectAlias {
    var columnName: String
    var asName: String?
}

struct JoinStatement {
    
}

struct DeleteStatement {
    var table: SQLTable.Type
    var whereAt: [String : WhereStatement]?
}

struct UpdateStatement {
    var table: SQLTable.Type
    var set: [String : Any]
    var whereAt: [String : WhereStatement]?
}

struct InsertStatement {
    var table: SQLTable.Type
    var columnValues: [Any]
}

struct WhereStatement {
    var clause: SQLiteClause
    var columnValue: Any
    var expression: SQLiteExpression
}
