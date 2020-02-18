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
            case .INT:
                guard let intValue = value as? Int else {
                    throw SQLiteError.DataType(message: "Value is not of type Int")
                }
                return String(intValue)
            case .none:
                throw SQLiteError.DataType(message: "Column is nil")
            }
        }
}
