//
//  LocationStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension LocationTable {
    static var getAllStatement: SelectStatement {
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: LocationTable.table, columnName: LocationTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: LocationTable.table, columnName: LocationTable.ColumnName.name.rawValue, asName: "name")
        
        return selectStatement
    }
}
