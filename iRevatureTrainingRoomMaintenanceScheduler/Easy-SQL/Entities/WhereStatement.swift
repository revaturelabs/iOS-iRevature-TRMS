//
//  WhereStatement.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

//===============================================================================================
    //Where Statement
//===============================================================================================
struct WhereStatement {

    //Variables To Use In Where Statement
    private var statement: [(table: SQLiteTable, columnName: String, columnData: WhereValue)]

    //Used to neatly store where statement data
    private struct WhereValue {
        var clause: SQLiteClause?
        var expression: SQLiteExpression
        var columnValue: Any
        
        //Assign all the data into the where value on instantiation
        init(clause: SQLiteClause, expression: SQLiteExpression, columnValue: Any) {
            self.clause = clause
            self.expression = expression
            self.columnValue = columnValue
        }
        
        //Assign all the data but the Clause into the where value on instantiation
        init(expression: SQLiteExpression, columnValue: Any) {
            self.expression = expression
            self.columnValue = columnValue
        }
    }

    //Initialize the where statement
    init() {
        statement = [(SQLiteTable, String, WhereValue)]()
    }

    //Add a statement with the clauses added
    mutating func addStatement(table: SQLiteTable, clause: SQLiteClause, columnName: String, expression: SQLiteExpression, columnValue: Any...) {
        
        let values = WhereValue(clause: clause, expression: expression, columnValue: columnValue)
        statement.append((table, columnName, values))
    }

    //Add a statement with the clauses added
    //Should only be called when it is the first expression
    mutating func addStatement(table: SQLiteTable, columnName: String, expression: SQLiteExpression, columnValue: Any...) {
        
        let values = WhereValue(expression: expression, columnValue: columnValue)
        statement.append((table, columnName, values))
    }
}

//===============================================================================================
    //Where Statement: Make Statement Functions
//===============================================================================================
extension WhereStatement: SQLiteStatement {
    
//===============================================================================================
    //Make the Where Statement based on all the information stored within the where statement
//===============================================================================================
    func makeStatement() -> String? {
        if statement.count <= 0 {
            return nil
        }
        
        var whereString: String = "\(SQLiteKeyword.WHERE) "
        
        //Iterate though the Values to check at certain columns
        for (index, whereData) in statement.enumerated() {
            let clause = whereData.columnData.clause
            let expression = whereData.columnData.expression
            let value = whereData.columnData.columnValue as! [Any]
            let table = whereData.table
            let columnName = whereData.columnName
            
            //Apply the clause keyword
            if let clauseString = makeClauseString(clause: clause) {
                whereString += clauseString
            } else if (index != 0) {
                return nil
            }
            
            //Apply Column Name
            let fullColumnName = "\(table.getTableName()).\(columnName)"
            whereString += fullColumnName
            
            //Apply Expression
            guard let expressionString = makeExpressionString(table: table, columnName: fullColumnName, expression: expression, value: value) else {
                return nil
            }
            
            whereString += expressionString
            
            //Add space if another statement needs to be added
            if index < statement.count - 1 {
                whereString += " "
            }
        }
        
        return whereString
    }
    
//===============================================================================================
    //Convert the SQLiteClause Enum into a String
//===============================================================================================
    private func makeClauseString(clause: SQLiteClause?) -> String? {
        //Convert clause to string if it is not nil or .NONE
        if let clause = clause {
            switch clause {
            case .NONE:
                return nil
            default:
                return "\(clause) "
            }
        }
        
        return nil
    }
    
//===============================================================================================
    //Create the expression based on the SQLite Expression Enum
//===============================================================================================
    private func makeExpressionString(table: SQLiteTable, columnName: String, expression: SQLiteExpression, value: [Any]) -> String? {
        
        //All values will be case into their appropriate type for SQLite
        //If cast fails, nil is returned
        switch expression {
            
        //Apply <ColumnName> <Expression> <ColumnValue>
        case .LESSTHAN, .GREATERTHAN, .EQUALS, .LESSTHANEQUALS, .GREATERTHANEQUALS:
            do {
                return " \(expression.rawValue) \(try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnName), value: value[0]))"
            } catch {
                return nil
            }
        
        //Apply <BETWEEN> <Value 1> <AND> <Value 2>
        //Will fail if the array is not equal to 2
        case .BETWEEN:
            if value.count != 2 {
                return nil
            }
            do {
                return " \(expression.rawValue) \(try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnName), value: value[0])) \(SQLiteClause.AND) \(try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnName), value: value[1]))"
            } catch {
                return nil
            }
        
        //Apply <Expression> <(> <Value...> <)>
        case .IN, .NOTIN:
            var inString = " \(expression.rawValue) "
            
            for (index, element) in value.enumerated() {
                if index == 0 {
                    inString += "("
                }
                
                do {
                    inString += try SQLUtility.castToDataType(column: table.getColumnData(columnName: columnName), value: element)
                } catch {
                    return nil
                }
                
                if index < value.count - 1 {
                    inString += ", "
                }
                else {
                    inString += ")"
                }
            }
            
            return inString
        }
    }
}
