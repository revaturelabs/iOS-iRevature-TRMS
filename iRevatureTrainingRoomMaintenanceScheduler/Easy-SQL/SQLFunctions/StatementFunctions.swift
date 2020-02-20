//
//  SQLUtilities.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

//class LeStatement {
//
////===============================================================================================
//    //Make A Statement Of All Column IDs
////===============================================================================================
//    static func makeIDStatement(columnNames: [String]?) -> String {
//        var idString: String = ""
//
//        //Assign values to select
//        if let columnNames = columnNames {
//            for (index, s) in columnNames.enumerated() {
//                idString += s
//
//                if index < columnNames.count - 1 {
//                    idString += ", "
//                }
//            }
//        }
//        else {
//            idString += "*"
//        }
//
//        return idString
//    }
//
////===============================================================================================
//    //Make A Statement Of All Column IDs
////===============================================================================================
//    static func makeColumnNameStatement(table: SQLTable.Type) -> String {
//        var iDString: String = ""
//
//        for (index, column) in table.columns.enumerated() {
//            //Add start statements
//            if (index == 0) {
//                iDString += "("
//            }
//
//            //Add column name
//            iDString += column.key
//
//            //Add spaces
//            if index < table.columns.count - 1 {
//                iDString += ", "
//            }
//            else {
//                iDString += ")"
//            }
//        }
//
//        return iDString
//    }
//
////===============================================================================================
//    //Make A Values Statement
////===============================================================================================
//    static func makeValueStatement(table: SQLTable.Type, values: [Any]) throws -> String {
//        var insertValueString: String = "\(SQLiteKeyword.VALUES) "
//
//        //Iterate through table columns
//        for (index, column) in table.columns.enumerated() {
//            //Add start statements
//            if (index == 0) {
//                insertValueString += "("
//            }
//
//            //Add column values
//            insertValueString += try SQLUtility.castToDataType(column: column.value, value: values[index])
//
//            //Add spaces
//            if index < table.columns.count - 1 {
//                insertValueString += ", "
//            }
//            else {
//                insertValueString += ")"
//            }
//        }
//
//        return insertValueString
//    }
//
////===============================================================================================
//    //Make A Set Statement
////===============================================================================================
//    static func makeSetStatement(table: SQLTable.Type, set: [String: Any]) throws -> String {
//        var setString: String = "\(SQLiteKeyword.SET) "
//
//        //Iterate through the Values to set in table
//        for (index, setHolder) in set.enumerated() {
//            //Add set information
//            setString += "\(setHolder.key) = \(try SQLUtility.castToDataType(column: table.columns[setHolder.key], value: setHolder.value))"
//
//            if index < set.count - 1 {
//                setString += ", "
//            }
//        }
//
//        return setString
//    }
//
//}
