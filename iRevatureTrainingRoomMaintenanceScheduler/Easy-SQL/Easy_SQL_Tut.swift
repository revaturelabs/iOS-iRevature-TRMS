//
//  Easy_SQL_Tut.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct Table {
    static var wesTable: SQLiteTable {
        var wesTable = SQLiteTable(tableName: "WesTable")
        wesTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        wesTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        return wesTable
    }
}

extension ViewController {
    func testWesStuff() {
        
        //Get databse filepath
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "WesDatabase", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open database
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
//=================================
        //Function calls for database currently implemented
//=================================
        //db?.createTable(table: <#T##SQLiteTable#>)
        //db?.dropTable(table: <#T##SQLiteTable#>)
        //db?.insertRow(statement: <#T##InsertStatement#>)
        //db?.updateRow(statement: <#T##UpdateStatement#>)
        //db?.deleteRow(statement: <#T##DeleteStatement#>)
        
//=================================
        //Statements
        //When making a statement, if it returns nil, the  statement has an error and was unable to be constructed
        //This is most likely due to a mismatch between the table columns and statements (Such as insert)
        //If for any reason the statements are continually returning nil when you know it is right,
        //you will need to restart Xcode
//=================================
        
//---------------------------------
        //Table creation
//        var wesTable = SQLiteTable(tableName: "WesTable")
//        wesTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
//        wesTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        if let statement = Table.wesTable.makeStatement() {
            print(statement)
        }
        
        var markTable = SQLiteTable(tableName: "MarkTable")
        markTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        markTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        if let markTable = markTable.makeStatement() {
            print(markTable)
        }
        
////---------------------------------
//        //Where statement
//        var whereStatement = WhereStatement()
//        whereStatement.addStatement(table: Table.wesTable, columnName: "name", expression: .EQUALS, columnValue: "Wes")
//        whereStatement.addStatement(table: markTable, clause: .OR, columnName: "name", expression: .EQUALS, columnValue: "Mark")
//
//        if let whereStatement = whereStatement.makeStatement() {
//            print(whereStatement)
//        }
//
////---------------------------------
//        //nsert statement
//        let insertStatement = InsertStatement(table: markTable, columnValues: 53, "Katelyn")
//        if let insertStatement = insertStatement.makeStatement() {
//            print(insertStatement)
//        }
//
//        do {
//            try db?.insertRow(statement: insertStatement)
//        } catch {
//
//        }
//
////---------------------------------
//        //Update statement
//        var updateStatement = UpdateStatement(table: Table.wesTable)
//        updateStatement.addValueChange(columnToUpdate: "name", updatedValue: "Mark")
//        updateStatement.setWhereStatement(statement: whereStatement)
//
//        if let updateStatement = updateStatement.makeStatement() {
//            print(updateStatement)
//        }
//
////---------------------------------
//        //Delete statement
//        var deleteStatement = DeleteStatement(table: Table.wesTable)
//        deleteStatement.setWhereStatement(statement: whereStatement)
//
//        if let deleteStatement = deleteStatement.makeStatement() {
//            print(deleteStatement)
//        }
//
//
//
//        var joinStatement = JoinStatement(table1: Table.wesTable, joinType: .INNER, table2: markTable, onColumnName1: "name", onColumnName2: "name")
//
//        if let joinStatement = joinStatement.makeStatement() {
//            print(joinStatement)
//        }
//
//
////---------------------------------
//        //Select statement
//        var selectStatement = SelectStatement()
//        selectStatement.specifyColumn(table: markTable, columnName: "id", asName: "number")
//
//        var selectWhere = WhereStatement()
//        selectWhere.addStatement(table: Table.wesTable, columnName: "name", expression: .EQUALS, columnValue: "Katelyn")
//
//        selectStatement.setJoinStatement(statement: joinStatement)
//        selectStatement.setWhereStatement(statement: selectWhere)
//
//        if let selectStatement = selectStatement.makeStatement() {
//            print(selectStatement)
//        }
//
//        do {
//            let result = try db?.selectData(statement: selectStatement)
//            var resultString = ""
//
//            if result != nil {
//                for row in result! {
//                    for (columnName, columnValue) in row {
//                        resultString += "\(columnName): \(columnValue), "
//                    }
//                    resultString += "\n"
//                }
//
//                print(resultString)
//            }
//
//
//        } catch {
//            print("failed")
//        }
    }
}
