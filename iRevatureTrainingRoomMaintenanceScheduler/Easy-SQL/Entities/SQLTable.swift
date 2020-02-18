//
//  Table.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

protocol SQLTable {
    typealias columnNameString = String
    static var columns: [columnNameString : Column] {get}
}

struct Column {
    var dataType: SQLiteDataType
    var constraints: [SQLiteConstraints]?
}


struct TestTable: SQLTable {
    static var columns: [Self.columnNameString : Column] {
        return ["id" : Column.init(dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
                "trainer" : Column.init(dataType: .CHAR ,constraints: nil)]
    }
    
}
