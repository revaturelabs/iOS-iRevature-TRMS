//
//  MaintenanceChartStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension MaintenanceChartTable {
    static func getMaintenanceChartRangeStatement(roomID: Int, startDate: Date, endDate: Date) -> SelectStatement {
        let dateFormat = SQLiteDateFormat.dateFormatter
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: table, columnName: ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: table, columnName: ColumnName.date.rawValue, asName: "date")
        selectStatement.specifyColumn(table: table, columnName: ColumnName.cleaned.rawValue, asName: "cleaned")
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.date.rawValue, expression: .BETWEEN, columnValue: dateFormat.string(from: startDate), dateFormat.string(from: endDate))
        whereStatement.addStatement(table: table, clause: .AND, columnName: ColumnName.roomID.rawValue, expression: .EQUALS, columnValue: roomID)
        
        
        selectStatement.setWhereStatement(statement: whereStatement)
        
        return selectStatement
    }
}
