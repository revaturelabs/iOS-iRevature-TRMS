//
//  RoomStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension RoomTable {
    
    static func insertStatement(roomApiID: String, roomName: String, roomLocationID: Int, campusID: Int, userID: Int) -> InsertStatement {
        var insertRoom = InsertStatement(table: table)
        insertRoom.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: roomApiID)
        insertRoom.specifyValue(columnName: ColumnName.name.rawValue, columnValue: roomName)
        insertRoom.specifyValue(columnName: ColumnName.location.rawValue, columnValue: roomLocationID)
        insertRoom.specifyValue(columnName: ColumnName.campus.rawValue, columnValue: campusID)
        insertRoom.specifyValue(columnName: ColumnName.assignedTo.rawValue, columnValue: userID)
        
        return insertRoom
    }
}
