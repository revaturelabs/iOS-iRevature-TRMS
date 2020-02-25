//
//  UserCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

extension UserTable {
    static func getAll(databaseName: String) -> [(trainerId: Int, trainerName: String)]? {
        guard let db = Database.getDatabase(databaseName: databaseName) else {
            return nil
        }
        
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.id.rawValue, asName: "id")
        selectStatement.specifyColumn(table: UserTable.table, columnName: UserTable.ColumnName.name.rawValue, asName: "name")
        
        do {
            let result = try db.selectData(statement: selectStatement)
            var trainerArray = [(trainerId: Int, trainerName: String)]()

            for row in result {
                var trainer = (trainerId: Int(), trainerName: String())

                for (columnName, value) in row {
                    switch columnName {
                    case "id":
                        trainer.trainerId = value as! Int
                    case "name":
                        trainer.trainerName = value as! String
                    default:
                        return nil
                    }
                }

                trainerArray.append(trainer)
            }

            return trainerArray
        } catch {
            
        }
        
        return nil
        
    }
}
