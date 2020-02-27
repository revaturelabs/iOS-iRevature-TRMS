//
//  CampusStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//
extension CampusTable {
    static func getByApiIDStatement(campusApiID: String) -> SelectStatement {
        var getCampus = SelectStatement()
        addSelectColumns(toStatement: &getCampus, withColumnNames: .id, .apiID, .name)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.apiID.rawValue, expression: .EQUALS, columnValue: campusApiID.trimmingCharacters(in: .whitespacesAndNewlines))
        
        getCampus.setWhereStatement(statement: whereStatement)
        
        return getCampus
    }
    
    static func insertStatement(campusApiID: String, campusName: String) -> InsertStatement {
        var insertCampus = InsertStatement(table: table)
        insertCampus.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: campusApiID)
        insertCampus.specifyValue(columnName: ColumnName.name.rawValue, columnValue: campusName)
        
        return insertCampus
    }
}
