//
//  MaintenanceChartTable.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Maintenance Chart Table
//============================
struct MaintenanceChartTable {
    private static let tableName = "maintenance_chart"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case date
        case roomID = "room_id"
        case inspectedByID = "user_id"
    }
    
    //Room Struct to return from select statement
    struct User {
        var id: Int
        var apiID: String
        var date: String
        var roomID: Int
        var inspectedByID: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.date = String()
            self.roomID = Int()
            self.inspectedByID = Int()
        }
        
        init(id: Int, apiID: String, date: String, roomID: Int, inspectedByID: Int) {
            self.id = id
            self.apiID = apiID
            self.date = date
            self.roomID = roomID
            self.inspectedByID = inspectedByID
        }
    }
    

    static var table: SQLiteTable {
        var maintenanceChartTable = SQLiteTable(tableName: tableName)
        
        maintenanceChartTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        maintenanceChartTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        maintenanceChartTable.addColumn(columnName: ColumnName.date.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        maintenanceChartTable.addColumn(columnName: ColumnName.roomID.rawValue, dataType: .INT, constraints: .NOTNULL)
        maintenanceChartTable.addColumn(columnName: ColumnName.inspectedByID.rawValue, dataType: .INT, constraints: nil)
        
        return maintenanceChartTable
    }
}
