//
//  GetData.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class SQLiteProcedures {
    
    static func getAllTrainers(databaseName: String) -> [Trainer]? {
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.name.rawValue, asName: "name")
        
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        do {
            let result = try db.selectData(statement: selectStatement)
            
            print(result)
        } catch {
            print("failed")
        }
        
        return nil
        
    }
}
