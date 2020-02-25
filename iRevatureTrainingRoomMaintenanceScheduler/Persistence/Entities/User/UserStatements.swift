//
//  UserStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension UserTable {
    static func getAllStatement() -> SelectStatement {
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.name.rawValue, asName: "name")
        
        return selectStatement
    }
}
