//
//  CampusTable.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Campus Table
//============================
struct CampusTable: DatabaseTable {
    private static let tableName = "campus"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
    }
    
    //Campus Struct to return from select statement
    struct User {
        var id: Int
        var apiID: String
        var name: String
        
        init() {
            self.id = Int()
            self.apiID = String()
            self.name = String()
        }
        
        init(id: Int, name: String, apiID: String, roleID: Int) {
            self.id = id
            self.apiID = apiID
            self.name = name
        }
    }
    

    static var table: SQLiteTable {
        var campusTable = SQLiteTable(tableName: tableName)
        
        campusTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        campusTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        campusTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        return campusTable
    }
}
