//
//  RoomTable.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Room Table
//============================
struct RoomTable: DatabaseTable {
    private static let tableName = "room"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
        case location = "location_id"
        case campus = "campus_id"
        case assignedTo = "user_id"
    }
    
    //Room Struct to return from select statement
    struct User {
        var id: Int
        var apiID: String
        var name: String
        var location: Int
        var campus: Int
        var assignedTo: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.name = String()
            self.location = Int()
            self.campus = Int()
            self.assignedTo = Int()
        }
        
        init(id: Int, name: String, apiID: String, roleID: Int, location: Int, campus: Int, assignedTo: Int) {
            self.id = id
            self.apiID = apiID
            self.name = name
            self.location = location
            self.campus = campus
            self.assignedTo = assignedTo
        }
    }
    

    static var table: SQLiteTable {
        var roomTable = SQLiteTable(tableName: tableName)
        
        roomTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        roomTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        roomTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        roomTable.addColumn(columnName: ColumnName.location.rawValue, dataType: .INT, constraints: .NOTNULL)
        roomTable.addColumn(columnName: ColumnName.campus.rawValue, dataType: .INT, constraints: .NOTNULL)
        roomTable.addColumn(columnName: ColumnName.assignedTo.rawValue, dataType: .INT, constraints: nil)
        
        return roomTable
    }
}
