//
//  Easy_SQL_Tut.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

//Constraints as nil or empty does not execute insert
struct WesTable {
    static var columns: [String : Column] {
        return ["id" : Column(dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
                "name" : Column(dataType: .CHAR, constraints: [.NOTNULL])]
    }
}

extension ViewController {
    func testWesStuff() {
        
        //Get databse filepath
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "WesDatabase", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open database
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
        //Create tabel in database
        do {
            //try db?.createTable(table: WesTable.self)
        } catch {
        }
        
        //Insert row into table
        do {
            
            //let insert = InsertStatement(table: WesTable.self, columnValues: [1, "Wes"])
            
            //try db?.insertRow(insert: insert)
        } catch {
            
        }
        
    
        //New Table creation
        var wesTable = SQLiteTable(tableName: "WesTable")
        wesTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        wesTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        if let wesTable = wesTable.makeStatement() {
            print(wesTable)
        }
        
        //New Where statement
        var whereStatement = WhereStatement(table: wesTable)
        whereStatement.addStatement(columnName: "name", expression: .EQUALS, columnValue: "Wes")
        whereStatement.addStatement(clause: .OR, columnName: "name", expression: .EQUALS, columnValue: "Mark")
        
        if let whereStatement = whereStatement.makeStatement() {
            print(whereStatement)
        }
        
        //New Insert statement
        let insertStatement = InsertStatement(table: wesTable, columnValues: 87, "Katelyn")
        if let insertStatement = insertStatement.makeStatement() {
            print(insertStatement)
        }
        
        //New Update statement
        var updateStatement = UpdateStatement(table: wesTable)
        updateStatement.addValueChange(columnToUpdate: "name", updatedValue: "Mark")
        updateStatement.setWhereStatement(statement: whereStatement)
        
        if let updateStatement = updateStatement.makeStatement() {
            print(updateStatement)
        }
            
        //New Delete statement
        var deleteStatement = DeleteStatement(table: wesTable)
        deleteStatement.setWhereStatement(statement: whereStatement)
        
        if let deleteStatement = deleteStatement.makeStatement() {
            print(deleteStatement)
        }
        
        //var tableInfo = TableSelectInfo(table: WesTable.self, ColumnNames: [SelectAlias(columnName: "id", asName: <#T##String?#>)])
        
        //SelectMultipleTableStatement(tableInfo: <#T##TableSelectInfo#>, joinAt: <#T##[JoinStatement]#>)
        
    }
}
