//
//  LocationCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension LocationTable {
    static func getAll(databaseName: String) -> [(locationID: Int, locationName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: LocationTable.table, columnName: UserTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: LocationTable.table, columnName: UserTable.ColumnName.name.rawValue, asName: "name")
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var locationArray = [(locationID: Int, locationName: String)]()

            for row in result {
                var location = (locationID: Int(), locationName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        location.locationID = value as! Int
                    case "name":
                        location.locationName = value as! String
                    default:
                        return nil
                    }
                }

                locationArray.append(location)
            }

            return locationArray
        } catch {
            
        }
        
        return nil
    }
    
    static func getByName(databaseName: String, locationName: String) -> (locationID: Int, locationName: String)? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = getAllStatement
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.name.rawValue, expression: .EQUALS, columnValue: locationName)
        
        selectStatement.setWhereStatement(statement: whereStatement)
        
        do {
            let result = try db.selectData(statement: selectStatement)

            for row in result {
                var location = (locationID: Int(), locationName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        location.locationID = value as! Int
                    case "name":
                        location.locationName = value as! String
                    default:
                        return nil
                    }
                }

                return location
            }
        } catch {
            return nil
        }
        
        return nil
        
    }
    
    static func insert(databaseName: String, apiID: String, locationName: String) -> Bool {
        if getByName(databaseName: databaseName, locationName: locationName) != nil {
            return false
        }
        
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return false
        }
        
        var insertStatement = InsertStatement(table: LocationTable.table)
        insertStatement.specifyValue(columnName: LocationTable.ColumnName.apiID.rawValue, columnValue: apiID)
        insertStatement.specifyValue(columnName: LocationTable.ColumnName.name.rawValue, columnValue: locationName)
        
        do {
            try db.insertRow(statement: insertStatement)
        } catch {
            return false
        }
        
        return true
    }
}
