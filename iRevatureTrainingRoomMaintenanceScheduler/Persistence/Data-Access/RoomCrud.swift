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
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.id.rawValue, asName: RoomTable.ColumnName.id.rawValue)
        selectStatement.specifyColumn(table: RoomTable.table, columnName: RoomTable.ColumnName.name.rawValue, asName: RoomTable.ColumnName.name.rawValue)
        

        var roomArray = [(roomID: Int, roomName: String)]()
        
        do {
            let result = try db.selectData(statement: selectStatement)

            for row in result {
                var room = (roomID: Int(), roomName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case RoomTable.ColumnName.id.rawValue:
                        room.roomID = value as! Int
                    case RoomTable.ColumnName.name.rawValue:
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
    
    static func insert(roomApiID: String, roomName: String, roomLocationID: Int, roomCampusID: Int, roomUserID: Int) -> Bool {
        if !Database.execute(insertStatement: insertStatement(roomApiID: roomApiID, roomName: roomName, roomLocationID: roomLocationID, campusID: roomCampusID, userID: roomUserID), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
}
