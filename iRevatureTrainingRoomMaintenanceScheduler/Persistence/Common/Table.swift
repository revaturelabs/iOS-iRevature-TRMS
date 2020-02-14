//
//  Table.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol SQLTable {
    typealias columnName = String
    static var columns: [columnName : Column] {get}
}

struct Column {
    var dataType: SQLiteDataType
    var constraints: [SQLiteConstraints]?
}


struct TestTable: SQLTable {
    static var columns: [Self.columnName : Column] {
        return ["id" : Column.init(dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
                "trainer" : Column.init(dataType: .CHAR ,constraints: nil)]
    }
    
}
