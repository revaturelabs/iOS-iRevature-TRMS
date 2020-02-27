//
//  SQLTables.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//



struct SQLTable {
    static let tables = [LocationTable.table,
                         CampusTable.table,
                         UserTable.table,
                         UserRoleTable.table,
                         RoomTable.table,
                         TaskTable.table,
                         RoomTaskTable.table,
                         MaintenanceChartTable.table,
                         MaintenanceChartTaskTable.table]
    
    static let dropTables = [LocationTable.table,
                            CampusTable.table,
                            UserTable.table,
                            UserRoleTable.table,
                            RoomTable.table,
                            TaskTable.table,
                            RoomTaskTable.table]
    
//============================
    //Location Table
//============================
    static var Location: SQLiteTable {
        var locationTable = SQLiteTable(tableName: "location")
        
        locationTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        locationTable.addColumn(columnName: "name", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        return locationTable
    }
    
//============================
    //Campus Table
//============================
    static var Campus: SQLiteTable {
        var campusTable = SQLiteTable(tableName: "campus")
        
        campusTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        campusTable.addColumn(columnName: "name", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        return campusTable
    }
    
//============================
    //User Table
//============================
    static var User: SQLiteTable {
        var userTable = SQLiteTable(tableName: "user")
        
        userTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        userTable.addColumn(columnName: "user_roler", dataType: .INT, constraints: .NOTNULL)
        
        return userTable
    }
    
//============================
    //User Role
//============================
    static var UserRole: SQLiteTable {
        var userRoleTable = SQLiteTable(tableName: "user_role")
        
        userRoleTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        userRoleTable.addColumn(columnName: "role_name", dataType: .CHAR, constraints: .UNIQUE)
        
        return userRoleTable
    }
    
//============================
    //Room Table
//============================
    static var Room: SQLiteTable {
        var roomTable = SQLiteTable(tableName: "room")
        
        roomTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        roomTable.addColumn(columnName: "name", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        roomTable.addColumn(columnName: "location_id", dataType: .INT, constraints: .NOTNULL)
        roomTable.addColumn(columnName: "campus_id", dataType: .INT, constraints: .NOTNULL)
        roomTable.addColumn(columnName: "user_id", dataType: .INT, constraints: nil)
        
        return roomTable
    }
    
//============================
    //Room Task Table
//============================
    static var RoomTask: SQLiteTable {
        var roomTaskTable = SQLiteTable(tableName: "room_task")
        
        roomTaskTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        roomTaskTable.addColumn(columnName: "date_start", dataType: .CHAR, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: "date_end", dataType: .CHAR, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: "room_id", dataType: .INT, constraints: .NOTNULL)
        roomTaskTable.addColumn(columnName: "task_id", dataType: .INT, constraints: .NOTNULL)
        
        return roomTaskTable
    }
    
//============================
    //Task Table
//============================
    static var Task: SQLiteTable {
        var taskTable = SQLiteTable(tableName: "task")
        
        taskTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        taskTable.addColumn(columnName: "name", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        return taskTable
    }
    
//============================
    //Maintenance Chart Table
//============================
    static var MaintenanceChart: SQLiteTable {
        var maintenanceChartTable = SQLiteTable(tableName: "maintenance_chart")
        
        maintenanceChartTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        maintenanceChartTable.addColumn(columnName: "date", dataType: .CHAR, constraints: .NOTNULL)
        maintenanceChartTable.addColumn(columnName: "room_id", dataType: .INT, constraints: .NOTNULL)
        maintenanceChartTable.addColumn(columnName: "user_id", dataType: .INT, constraints: .NOTNULL)
        
        return maintenanceChartTable
    }
    
//============================
    //Maintenance Chart Task Table
//============================
    static var MaintenanceChartTask: SQLiteTable {
        var maintenanceChartTaskTable = SQLiteTable(tableName: "maintenance_chart_task")
        
        maintenanceChartTaskTable.addColumn(columnName: "id", dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: "completed", dataType: .BOOL, constraints: .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: "maintenance_chart_id", dataType: .INT, constraints: .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: "task_id", dataType: .INT, constraints: .NOTNULL)
        
        return maintenanceChartTaskTable
    }
}
