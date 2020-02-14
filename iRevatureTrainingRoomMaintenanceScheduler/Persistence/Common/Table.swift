//
//  Table.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol SQLTable {
    static var columns: [Column] {get}
}

struct Column {
    var name: String
    var dataType: SQLiteDataType
    var constraints: [SQLiteConstraints]?
}


struct TestTable: SQLTable {
    static var columns: [Column] {
        return [Column.init(name: "id", dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
                Column.init(name: "trainer",dataType: .CHAR ,constraints: nil)]
    }
    
}
