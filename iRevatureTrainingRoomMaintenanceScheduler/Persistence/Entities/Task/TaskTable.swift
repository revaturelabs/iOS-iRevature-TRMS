//
//  TaskTable.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Task Table
//============================
struct TaskTable: DatabaseTable {
    private static let tableName = "task"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
    }
    
    //Room Struct to return from select statement
    struct User {
        var id: Int
        var apiID: String
        var name: String
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.name = String()
        }
        
        init(id: Int, apiID: String, name: String) {
            self.id = id
            self.apiID = apiID
            self.name = name
        }
    }
    

    static var table: SQLiteTable {
        var taskTable = SQLiteTable(tableName: tableName)
        
        taskTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        taskTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        taskTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        return taskTable
    }
}
