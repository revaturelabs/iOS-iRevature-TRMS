//
//  Easy_SQL_Tut.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

//Constraints as nil or empty does not execute insert
struct WesTable: SQLTable {
    static var columns: [Self.columnNameString : Column] {
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
            try db?.createTable(table: WesTable.self)
        } catch {
        }
        
        //Insert row into table
        do {
            
            let insert = InsertStatement(table: WesTable.self, columnValues: [1, "Wes"])
            
            try db?.insertRow(insert: insert)
        } catch {
            
        }
        
        //update row in table
        do {
            var update = UpdateStatement(table: WesTable.self, set: ["name" : "Wes"])
            update.whereAt = ["id" : WhereStatement(clause: .NONE, columnValue: 1, expression: .EQUALS)]
            
            try db?.updateRow(update: update)
            
        } catch {
            
        }
        
        //var tableInfo = TableSelectInfo(table: WesTable.self, ColumnNames: [SelectAlias(columnName: "id", asName: <#T##String?#>)])
        
        //SelectMultipleTableStatement(tableInfo: <#T##TableSelectInfo#>, joinAt: <#T##[JoinStatement]#>)
        
    }
}
