//
//  RoomCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension RoomTable {
    
    static func getAll(databaseName: String) -> [(roomID: Int, roomName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.name.rawValue, asName: "name")
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var roomArray = [(roomID: Int, roomName: String)]()

            for row in result {
                var room = (roomID: Int(), roomName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        room.roomID = value as! Int
                    case "name":
                        room.roomName = value as! String
                    default:
                        return nil
                    }
                }

                roomArray.append(room)
            }

            return roomArray
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func getByUser(databaseName: String, userID: Int) -> [(roomID: Int, roomName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.name.rawValue, asName: "name")
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: RoomTable.table, columnName: RoomTable.ColumnName.assignedTo.rawValue, expression: .EQUALS, columnValue: userID)
        
        selectStatement.setWhereStatement(statement: whereStatement)
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var roomArray = [(roomID: Int, roomName: String)]()

            for row in result {
                var room = (roomID: Int(), roomName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        room.roomID = value as! Int
                    case "name":
                        room.roomName = value as! String
                    default:
                        return nil
                    }
                }

                roomArray.append(room)
            }

            return roomArray
        } catch {
            print(error)
        }
        
        return nil
    }
}
