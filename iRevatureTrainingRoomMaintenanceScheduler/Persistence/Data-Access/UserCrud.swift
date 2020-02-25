//
//  UserCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import os.log

extension UserTable {
    static func getAll(databaseName: String) -> [(trainerId: Int, trainerName: String)]? {
        
        guard let result = Database.execute(selectStatement: getAllStatement(), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else {
            return nil
        }
        
        var trainerArray = [(trainerId: Int, trainerName: String)]()
        
        for data in resultStruct {
            trainerArray.append((trainerId: data.id, trainerName: data.name))
        }

        return trainerArray
        
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [UserTable.User]? {
        var userArray = result.isEmpty ? nil : [UserTable.User]()
        
        for row in result {
            var user = UserTable.User()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    user.id = value as! Int
                case ColumnName.apiID.rawValue:
                    user.apiID = value as! String
                case ColumnName.name.rawValue:
                    user.name = value as! String
                case ColumnName.locationID.rawValue:
                    user.locationID = value as! Int
                default:
                    return nil
                }
            }

            if userArray != nil {
                userArray!.append(user)
            }
        }

        return userArray
    }
}
