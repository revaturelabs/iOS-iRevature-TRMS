//
//  TaskStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension TaskTable {
    static func getByIDStatement(taskID: Int) -> SelectStatement {
        var selectTask = SelectStatement()
        addSelectColumns(toStatement: &selectTask, withColumnNames: .id, .apiID, .name)
        
        var whereTask = WhereStatement()
        whereTask.addStatement(table: table, columnName: ColumnName.id.rawValue, expression: .EQUALS, columnValue: taskID)
        
        selectTask.setWhereStatement(statement: whereTask)
        
        return selectTask
    }
    
    static func getByNameStatement(taskName: String) -> SelectStatement {
        var selectTask = SelectStatement()
        addSelectColumns(toStatement: &selectTask, withColumnNames: .id, .apiID, .name)
        
        var whereTask = WhereStatement()
        whereTask.addStatement(table: table, columnName: ColumnName.name.rawValue, expression: .EQUALS, columnValue: taskName)
        
        selectTask.setWhereStatement(statement: whereTask)
        
        return selectTask
    }
    
    static func insertStatement(taskApiID: String, taskName: String) -> InsertStatement {
        var insertTask = InsertStatement(table: table)
        insertTask.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: taskApiID)
        insertTask.specifyValue(columnName: ColumnName.name.rawValue, columnValue: taskName)
        
        return insertTask
    }
    
}
