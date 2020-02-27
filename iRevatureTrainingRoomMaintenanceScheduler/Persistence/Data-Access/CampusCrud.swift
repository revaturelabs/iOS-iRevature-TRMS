//
//  CampusCrud.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/27/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension CampusTable {
    static func getByApiID (campusApiID: String) -> Campus? {
        guard let result = Database.execute(selectStatement: getByApiIDStatement(campusApiID: campusApiID), fromDatabase: DatabaseInfo.databaseName), let resultStruct = applyDataToStruct(result: result) else { return nil }
        
        return resultStruct[0]
    }
    
    static func insert(campusApiID: String, campusName: String) -> Bool {
        if !Database.execute(insertStatement: insertStatement(campusApiID: campusApiID, campusName: campusName), fromDatabase: DatabaseInfo.databaseName) {
            return false
        }
        
        return true
    }
    
    static func applyDataToStruct(result: [[String : Any]]) -> [Campus]? {
        if result.isEmpty {
            return nil
        }
        
        var campusArray = [Campus]()
        
        for row in result {
            var campus = Campus()

            for (columnName, value) in row {
                switch columnName {
                case ColumnName.id.rawValue:
                    campus.id = value as! Int
                case ColumnName.apiID.rawValue:
                    campus.apiID = value as! String
                case ColumnName.name.rawValue:
                    campus.name = value as! String
                default:
                    return nil
                }
            }
            
            campusArray.append(campus)
        }

        return campusArray
    }
}
