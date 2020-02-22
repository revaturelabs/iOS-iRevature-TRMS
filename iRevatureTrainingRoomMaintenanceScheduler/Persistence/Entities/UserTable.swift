//
//  User.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //User Table
//============================
struct UserTable {
    private static let tableName = "user"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
        case locationID = "location_id"
    }
    
    //User Struct to return from select statement
    struct User {
        var id: Int
        var apiID: String
        var name: String
        var locationID: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.name = String()
            self.locationID = Int()
        }
        
        init(id: Int, apiID: String, name: String, locationID: Int) {
            self.id = id
            self.apiID = apiID
            self.name = name
            self.locationID = locationID
        }
    }
    
    static var table: SQLiteTable {
        var userTable = SQLiteTable(tableName: tableName)
        
        userTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        userTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        userTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        userTable.addColumn(columnName: ColumnName.locationID.rawValue, dataType: .INT, constraints: .NOTNULL)
        
        return userTable
    }
}
