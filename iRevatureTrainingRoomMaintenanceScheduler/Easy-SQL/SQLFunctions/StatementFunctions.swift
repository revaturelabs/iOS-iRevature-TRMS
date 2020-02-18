//
//  SQLUtilities.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

class SQLStatement {
    
//===============================================================================================
    //Make A Table Statement
//===============================================================================================
    static func makeTableStatement(table: SQLTable.Type) -> String {
        var columnString: String = "\(SQLiteKeyword.TABLE) \(table) "
        
        for (index, column) in table.columns.enumerated() {
            //Apply comma for new column
            if index == 0 {
                columnString += "("
            }
            else {
                columnString += ", "
            }
            
            //Assign column name
            columnString += column.key
            
            //Assign datatype formatting
            switch column.value.dataType {
            case .CHAR:
                columnString += " \(column.value.dataType.rawValue)(255)"
            default:
                columnString += " \(column.value.dataType.rawValue)"
            }
            
            //Assign column constraints
            if column.value.constraints != nil {
                for i in 0 ..< column.value.constraints!.count {
                    columnString += " \(column.value.constraints![i].rawValue)"
                }
            }
        }
        
        columnString += ")"
        
        return columnString
    }

//===============================================================================================
    //Make A Statement Of All Column IDs
//===============================================================================================
    static func makeIDStatement(columnNames: [String]?) -> String {
        var idString: String = ""
        
        //Assign values to select
        if let columnNames = columnNames {
            for (index, s) in columnNames.enumerated() {
                idString += s
                
                if index < columnNames.count - 1 {
                    idString += ", "
                }
            }
        }
        else {
            idString += "*"
        }
        
        return idString
    }
    
//===============================================================================================
    //Make A Statement Of All Column IDs
//===============================================================================================
    static func makeColumnNameStatement(table: SQLTable.Type) -> String {
        var iDString: String = ""
        
        for (index, column) in table.columns.enumerated() {
            //Add start statements
            if (index == 0) {
                iDString += "("
            }
            
            //Add column name
            iDString += column.key
            
            //Add spaces
            if index < table.columns.count - 1 {
                iDString += ", "
            }
            else {
                iDString += ")"
            }
        }
        
        return iDString
    }
    
//===============================================================================================
    //Make A Values Statement
//===============================================================================================
    static func makeValueStatement(table: SQLTable.Type, values: [Any]) throws -> String {
        var insertValueString: String = "\(SQLiteKeyword.VALUES) "
        
        //Iterate through table columns
        for (index, column) in table.columns.enumerated() {
            //Add start statements
            if (index == 0) {
                insertValueString += "("
            }
            
            //Add column values
            insertValueString += try SQLUtility.castToDataType(column: column.value, value: values[index])
            
            //Add spaces
            if index < table.columns.count - 1 {
                insertValueString += ", "
            }
            else {
                insertValueString += ")"
            }
        }
        
        return insertValueString
    }
    
//===============================================================================================
    //Make A Set Statement
//===============================================================================================
    static func makeSetStatement(table: SQLTable.Type, set: [String: Any]) throws -> String {
        var setString: String = "\(SQLiteKeyword.SET) "
        
        //Iterate through the Values to set in table
        for (index, setHolder) in set.enumerated() {
            //Add set information
            setString += "\(setHolder.key) = \(try SQLUtility.castToDataType(column: table.columns[setHolder.key], value: setHolder.value))"
            
            if index < set.count - 1 {
                setString += ", "
            }
        }
        
        return setString
    }

//===============================================================================================
    //Make A Where Statement
//===============================================================================================
    static func makeWhereStatement(table: SQLTable.Type, at: [String : WhereStatement]) throws -> String {
        var whereString: String = "\(SQLiteKeyword.WHERE) "
        
        //Iterate though the Values to check at certain columns
        for (index, atHolder) in at.enumerated() {
            let clause = atHolder.value.clause
            let expression = atHolder.value.expression
            let value = atHolder.value.columnValue
            
            //Add to where information
            switch clause {
            case .NONE:
                break
            default:
                whereString += "\(clause) "
            }
            
            whereString += "\(atHolder.key)"
            
            switch expression {
            case .LESSTHAN, .GREATERTHAN, .EQUALS, .LESSTHANEQUALS, .GREATERTHANEQUALS:
                whereString += " \(expression.rawValue) \(try SQLUtility.castToDataType(column: table.columns[atHolder.key], value: value))"
                
            case .BETWEEN:
                let tempArray = value as! [Any]
                if tempArray.count != 2 {
                    throw SQLiteError.Update(message: "Error assigning BETWEEN expression")
                }
                whereString += " \(expression.rawValue) \(try SQLUtility.castToDataType(column: table.columns[atHolder.key], value: tempArray[0])) \(SQLiteClause.AND) \(try SQLUtility.castToDataType(column: table.columns[atHolder.key], value: tempArray[1]))"
                
            case .IN, .NOTIN:
                let tempArray = value as! [Any]
                
                whereString += " \(expression.rawValue) "
                
                for (index, element) in tempArray.enumerated() {
                    if index == 0 {
                        whereString += "("
                    }
                    
                    whereString += try SQLUtility.castToDataType(column: table.columns[atHolder.key], value: element)
                    
                    if index < tempArray.count - 1 {
                        whereString += ", "
                    }
                    else {
                        whereString += ")"
                    }
                }
            }
            
            if index < at.count - 1 {
                whereString += " "
            }
        }
        
        return whereString
    }
}
