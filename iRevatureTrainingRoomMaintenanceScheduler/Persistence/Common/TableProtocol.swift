//
//  TableProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

protocol DatabaseTable {
    associatedtype ColumnName: RawRepresentable
    
    static var table: SQLiteTable { get }
}

extension DatabaseTable {
    static func addSelectColumns(toStatement statement: inout SelectStatement, withColumnNames columnNames: ColumnName...) {
        for name in columnNames {
            let name = name.rawValue as! String
            
            statement.specifyColumn(table: table, columnName: name, asName: name)
        }
    }
}
