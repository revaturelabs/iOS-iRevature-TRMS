//
//  MaintenanceChartTask.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//


//============================
    //Maintenance Chart Task Table
//============================
struct MaintenanceChartTaskTable: DatabaseTable {
    private static let tableName = "maintenance_chart_task"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case completed
        case maintenanceChartID = "maintenance_chart_id"
        case taskID = "task_id"
    }
    
    //Room Struct to return from select statement
    struct MaintenanceChartTask {
        var id: Int
        var apiID: String
        var completed: Bool
        var maintenanceChartID: Int
        var taskID: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.completed = Bool()
            self.maintenanceChartID = Int()
            self.taskID = Int()
        }
        
        init(id: Int, apiID: String, completed: Bool, maintenanceChartID: Int, taskID: Int) {
            self.id = id
            self.apiID = apiID
            self.completed = completed
            self.maintenanceChartID = maintenanceChartID
            self.taskID = taskID
        }
    }
    

    static var table: SQLiteTable {
        var maintenanceChartTaskTable = SQLiteTable(tableName: tableName)
        
        maintenanceChartTaskTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: ColumnName.completed.rawValue, dataType: .BOOL, constraints: .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: ColumnName.maintenanceChartID.rawValue, dataType: .INT, constraints: .NOTNULL)
        maintenanceChartTaskTable.addColumn(columnName: ColumnName.taskID.rawValue, dataType: .INT, constraints: .NOTNULL)
        
        return maintenanceChartTaskTable
    }
}
