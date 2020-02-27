//
//  RoomTaskStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension RoomTaskTable {
    static func getTasksByDate(roomID: Int, date: Date) -> SelectStatement {
        let dateFormat = SQLiteDateFormat.dateFormatter
        
        var selectStatement = SelectStatement()
        addSelectColumns(toStatement: &selectStatement, withColumnNames: .id, .taskID)
        TaskTable.addSelectColumns(toStatement: &selectStatement, withColumnNames: .name)
        
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
    
    static func insertStatement(roomTaskApiID: String, dateStart: String, dateEnd: String, roomID: Int, roomTaskID: Int) -> InsertStatement {
        var insertRoomTask = InsertStatement(table: table)
        insertRoomTask.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: roomTaskApiID)
        insertRoomTask.specifyValue(columnName: ColumnName.dateStart.rawValue, columnValue: dateStart)
        insertRoomTask.specifyValue(columnName: ColumnName.dateEnd.rawValue, columnValue: dateEnd)
        insertRoomTask.specifyValue(columnName: ColumnName.roomID.rawValue, columnValue: roomID)
        insertRoomTask.specifyValue(columnName: ColumnName.taskID.rawValue, columnValue: roomTaskID)
        
        return insertRoomTask
    }
}
