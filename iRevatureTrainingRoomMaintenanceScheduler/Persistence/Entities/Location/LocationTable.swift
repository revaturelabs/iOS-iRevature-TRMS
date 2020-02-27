//
//  Location.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

//============================
    //Location Table
//============================
struct LocationTable: DatabaseTable {
    private static let tableName = "location"
    
    //Column name abstraction
    enum ColumnName: String {
        case id
        case apiID = "api_id"
        case name
    }
    
    //Location Struct to return from select
    struct Location {
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
    
    //Table Creation
    static var table: SQLiteTable {
        var locationTable = SQLiteTable(tableName: tableName)
        
        locationTable.addColumn(columnName: ColumnName.id.rawValue, dataType: .INTEGER, constraints: .PRIMARYKEY, .AUTOINCREMENT, .NOTNULL)
        locationTable.addColumn(columnName: ColumnName.apiID.rawValue, dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        locationTable.addColumn(columnName: ColumnName.name.rawValue, dataType: .CHAR, constraints: .NOTNULL)
        
        return locationTable
    }
    
    //Create Table
    static func createTableStatement() -> String? {
        if let statement = self.table.makeStatement() {
            return statement
        }
        
        return nil
    }
    
    //Convert sql result from Easy_SQL to a struct array
    private static func convertSQLResult(result: [[String : Any]]?) -> [Location]? {
        var locationArray = [Location]()
        
        for row in result! {
            var location = Location()
            
            for (columnName, value) in row {
                switch columnName {
                case "ID":
                    location.id = value as! Int
                case "Name":
                    location.name = value as! String
                default:
                    break
                }
            }
            
            locationArray.append(location)
        }
        
        return locationArray
    }
}

extension LocationTable {
    //Get all data in database
    static func getAllValues(database: DatabaseAccess) -> [Location]? {
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: self.table, columnName: ColumnName.id.rawValue, asName: "ID")
        selectStatement.specifyColumn(table: self.table, columnName: ColumnName.name.rawValue, asName: "Name")
        
        do {
            let result = try database.selectData(statement: selectStatement)
            return convertSQLResult(result: result)
            
        } catch {
            return nil
        }
    }
}
