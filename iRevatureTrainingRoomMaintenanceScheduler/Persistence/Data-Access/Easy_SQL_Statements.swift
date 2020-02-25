//
//  Easy_SQL_Statements.swift
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

extension RoomTaskTable {
    static func getTasksByDate(roomID: Int, date: Date) -> SelectStatement {
        let dateFormat = SQLiteDateFormat.dateFormatter
        
        //Select Statement
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: table, columnName: ColumnName.id.rawValue, asName: "room_task_id")
        selectStatement.specifyColumn(table: TaskTable.table, columnName: TaskTable.ColumnName.id.rawValue, asName: "task_id")
        selectStatement.specifyColumn(table: TaskTable.table, columnName: TaskTable.ColumnName.name.rawValue, asName: "task_name")
        
        //Join RoomTaskTable and TaskTable on RoomTask.taskID == Task.id
        let joinStatement = JoinStatement(table1: table, joinType: .INNER, table2: TaskTable.table, onColumnName1: ColumnName.taskID.rawValue, onColumnName2: TaskTable.ColumnName.id.rawValue)
        
        //Where statement:  date < RoomTask.EndDate, date > RoomTask.StartDate, RoomTask.roomID == roomID
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.dateStart.rawValue, expression: .LESSTHAN, columnValue: dateFormat.string(from: date))
        whereStatement.addStatement(table: table, clause: .AND, columnName: ColumnName.dateEnd.rawValue, expression: .GREATERTHAN, columnValue: dateFormat.string(from: date))
        whereStatement.addStatement(table: table, clause: .AND, columnName: ColumnName.roomID.rawValue
            , expression: .EQUALS, columnValue: roomID)
        
        selectStatement.setJoinStatement(statement: joinStatement)
        selectStatement.setWhereStatement(statement: whereStatement)
        
        return selectStatement
    }
    
}

extension LocationTable {
    static var getAllStatement: SelectStatement {
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: LocationTable.table, columnName: LocationTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: LocationTable.table, columnName: LocationTable.ColumnName.name.rawValue, asName: "name")
        
        return selectStatement
    }
}
