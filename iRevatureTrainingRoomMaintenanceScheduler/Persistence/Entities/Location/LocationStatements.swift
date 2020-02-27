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
    
    static func getByApiIDStatement(locationApiID: String) -> SelectStatement {
        var selectLocation = SelectStatement()
        addSelectColumns(toStatement: &selectLocation, withColumnNames: .id, .apiID, .name)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.apiID.rawValue, expression: .EQUALS, columnValue: locationApiID.trimmingCharacters(in: .whitespacesAndNewlines))
        
        selectLocation.setWhereStatement(statement: whereStatement)
        
        return selectLocation
    }
}
