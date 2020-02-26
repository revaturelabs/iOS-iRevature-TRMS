//
//  MaintenanceChartTaskStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension MaintenanceChartTaskTable {
    static func getByIDStatement(maintenanceChartID: Int, taskID: Int) -> SelectStatement {
        var selectChartTask = SelectStatement()
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.id.rawValue, asName: ColumnName.id.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.maintenanceChartID.rawValue, asName: ColumnName.maintenanceChartID.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.taskID.rawValue, asName: ColumnName.taskID.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.completed.rawValue, asName: ColumnName.completed.rawValue)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.maintenanceChartID.rawValue, expression: .EQUALS, columnValue: maintenanceChartID)
        whereStatement.addStatement(table: table, columnName: ColumnName.taskID.rawValue, expression: .EQUALS, columnValue: taskID)
        
        selectChartTask.setWhereStatement(statement: whereStatement)
        
        return selectChartTask
    }
    
    static func getByMaintenanceChartIDStatement(maintenanceChartID: Int) -> SelectStatement {
        var selectChartTask = SelectStatement()
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.id.rawValue, asName: ColumnName.id.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.maintenanceChartID.rawValue, asName: ColumnName.maintenanceChartID.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.taskID.rawValue, asName: ColumnName.taskID.rawValue)
        selectChartTask.specifyColumn(table: table, columnName: ColumnName.completed.rawValue, asName: ColumnName.completed.rawValue)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.maintenanceChartID.rawValue, expression: .EQUALS, columnValue: maintenanceChartID)
        
        selectChartTask.setWhereStatement(statement: whereStatement)
        
        return selectChartTask
    }
    
    
    static func insertStatement(maintencanceChartID: Int, taskID: Int, completed: Bool) -> InsertStatement {
        
        var insertChartTask = InsertStatement(table: table)
        insertChartTask.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: "")
        insertChartTask.specifyValue(columnName: ColumnName.taskID.rawValue, columnValue: taskID)
        insertChartTask.specifyValue(columnName: ColumnName.maintenanceChartID.rawValue, columnValue: maintencanceChartID)
        insertChartTask.specifyValue(columnName: ColumnName.completed.rawValue, columnValue: completed)
        
        return insertChartTask
    }
    
    static func updateStatement(maintenanceChartID: Int, taskID: Int, completed: Bool) -> UpdateStatement {
        var updateStatement = UpdateStatement(table: table)
        updateStatement.addValueChange(columnToUpdate: ColumnName.completed.rawValue, updatedValue: completed)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.maintenanceChartID.rawValue, expression: .EQUALS, columnValue: maintenanceChartID)
        whereStatement.addStatement(table: table, clause: .AND, columnName: ColumnName.taskID.rawValue, expression: .EQUALS, columnValue: taskID)
        
        updateStatement.setWhereStatement(statement: whereStatement)
        
        return updateStatement
    }
}
