//
//  MaintenanceChartStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension MaintenanceChartTable {
    static func getByDateStatement(roomID: Int, date: Date) -> SelectStatement {
        let dateFormat = SQLiteDateFormat.dateFormatter
        
        var selectStatement = SelectStatement()
        addSelectColumns(toStatement: &selectStatement, withColumnNames: .id, .cleaned, .inspectedByID)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.date.rawValue, expression: .EQUALS, columnValue: dateFormat.string(from: date))
        whereStatement.addStatement(table: table, clause: .AND, columnName: ColumnName.roomID.rawValue, expression: .EQUALS, columnValue: roomID)
        
        selectStatement.setWhereStatement(statement: whereStatement)
        
        return selectStatement
    }
    
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
    
    static func insertStatement(roomID: Int, assignedUserID: Int, completed: Bool) -> InsertStatement {
        let dateString = SQLiteDateFormat.dateFormatter.string(from: Date())
        
        var chartInsert = InsertStatement(table: table)
        chartInsert.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: dateString)
        chartInsert.specifyValue(columnName: ColumnName.date.rawValue, columnValue: dateString)
        chartInsert.specifyValue(columnName: ColumnName.roomID.rawValue, columnValue: roomID)
        chartInsert.specifyValue(columnName: ColumnName.inspectedByID.rawValue, columnValue: assignedUserID)
        chartInsert.specifyValue(columnName: ColumnName.cleaned.rawValue, columnValue: completed)
        
        return chartInsert
    }
    
    static func updateStatement(maintenanceChartID: Int, completed: Bool?, inspectedByID: Int?) -> UpdateStatement {
        var chartUpdate = UpdateStatement(table: table)
        
        if let completed = completed {
            chartUpdate.addValueChange(columnToUpdate: ColumnName.cleaned.rawValue, updatedValue: completed)
        }
        
        if let inspectedByID = inspectedByID {
            chartUpdate.addValueChange(columnToUpdate: ColumnName.inspectedByID.rawValue, updatedValue: inspectedByID)
        }
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.id.rawValue, expression: .EQUALS, columnValue: maintenanceChartID)
        
        chartUpdate.setWhereStatement(statement: whereStatement)
        
        return chartUpdate
    }
}
