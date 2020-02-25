//
//  UserRole.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //User Table
//============================
struct UserRoleTable: DatabaseTable {
    private static let tableName = "user_role"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
    }
    
    //UserRole Struct to return from select statement
    struct UserRole {
        var id: Int
        var apiID: String
        var role: Int
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.role = Int ()
        }
        
        init(id: Int, name: String, apiID: String, role: Int) {
            self.id = id
            self.apiID = apiID
            self.role = role
        }
    }
    
    static var table: SQLiteTable {
        var userTable = SQLiteTable(tableName: tableName)
        
        userTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        userTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        userTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .INT, constraints: .NOTNULL, .UNIQUE)
        
        return userTable
    }
}
