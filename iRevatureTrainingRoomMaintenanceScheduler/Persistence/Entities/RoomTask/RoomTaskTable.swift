//
//  RoomTaskTable.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Room Tasks Table
//============================
struct RoomTaskTable: DatabaseTable {
    private static let tableName = "room_task"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case dateStart = "date_start"
        case dateEnd = "date_end"
        case roomID = "room_id"
        case taskID = "task_id"
    }
    
    //Room Struct to return from select statement
    struct RoomTask {
        var id: Int
        var apiID: String
        var dateStart: String
        var dateEnd: String
        var roomID: Int
        var taskID: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.dateStart = String()
            self.dateEnd = String()
            self.roomID = Int()
            self.taskID = Int()
        }
        
        init(id: Int, apiID: String, dateStart: String, dateEnd: String, roomID: Int, taskID: Int) {
            self.id = id
            self.apiID = apiID
            self.dateStart = dateStart
            self.dateEnd = dateEnd
            self.roomID = roomID
            self.taskID = taskID
        }
    }
    

    static var table: SQLiteTable {
        var roomTaskTable = SQLiteTable(tableName: tableName)
        
        roomTaskTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        roomTaskTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: ColumnName.dateStart.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: ColumnName.dateEnd.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: ColumnName.roomID.rawValue, dataType: .INT, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: ColumnName.taskID.rawValue, dataType: .INT, constraints: .NOTNULL)
        
        return roomTaskTable
    }
}
