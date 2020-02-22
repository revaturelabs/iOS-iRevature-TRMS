//
//  HelperFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class SQLUtility {
//===============================================================================================
    //Cast Swift Data Type To SQL Version
//===============================================================================================
    //Check to see if the value is matching the table type
    static func castToDataType (column: Column?, value: Any) throws -> String {
        
        switch column?.dataType {
        case .CHAR:
            guard let stringValue = value as? String else {
                throw SQLiteError.DataType(message: "Value is not of type String")
            }
            return "'\(stringValue)'"
        case .INT, .INTEGER:
            guard let intValue = value as? Int else {
                throw SQLiteError.DataType(message: "Value is not of type Int")
            }
            return String(intValue)
        case .BOOL:
            guard let boolValue = value as? Bool else {
                throw SQLiteError.DataType(message: "Value is not of type Int")
            }
            return boolValue ? "1" : "0"
        default:
            throw SQLiteError.DataType(message: "Column is nil")
        }
    }
    
//===============================================================================================
    //Get column name
//===============================================================================================
    //Check to see if the value is matching the table type
//    static func getColumnReferencingTableName(table: SQLiteTable, columnName: String) -> String {
//        return "\(table.getTableName()).\(columnName)"
//    }
}
