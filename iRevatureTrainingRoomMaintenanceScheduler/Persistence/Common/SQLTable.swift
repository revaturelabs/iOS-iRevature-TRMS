//
//  Table.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

protocol SQLTable {
    typealias columnNameString = String
    static var columns: [columnNameString : Column] {get}
}

struct Column {
    var dataType: SQLiteDataType
    var constraints: [SQLiteConstraints]?
}


struct TestTable: SQLTable {
    static var columns: [Self.columnNameString : Column] {
        return ["id" : Column.init(dataType: .INT, constraints: [.PRIMARYKEY, .NOTNULL]),
                "trainer" : Column.init(dataType: .CHAR ,constraints: nil)]
    }
    
}

extension ViewController {
    func testStuff() {
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "MyDatabase", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
//        do {
//            try db?.dropTable(table: TestTable.self)
//        } catch {
//
//        }
//        do {
//            try db?.createTable(table: TestTable.self)
//        } catch {
//            print("failed create table")
//        }
//
//        do {
//            try db?.insertRow(insert: InsertStatement(table: TestTable.self, columnValues: [5387, "Katelyn"]))
//        } catch {
//            print("failed insert row")
//        }

//        do {
//            try db?.updateRow(table: TestTable.self, set: ["trainer": "BOOPY"], at: ["trainer": (.NONE, "Mark", .EQUALS), "id": (.OR, [35, 53, 76, 102], .IN)])
//        } catch {
//            print("failed update row")
//        }
//
//        do {
//            try db?.deleteRow(table: TestTable.self, at: ["id" : (.NONE, 53, .EQUALS)])
//        } catch {
//            print("failed delete row")
//        }
        
        do {
            
            var testStatement = SelectStatement(table: TestTable.self)
            testStatement.columnNames = ["id", "trainer"]
            testStatement.whereAt =
                ["id" : WhereStatement(clause: .NONE, columnValue: 5387, expression: .EQUALS),
                 "trainer" : WhereStatement(clause: .OR, columnValue: "Mark", expression: .EQUALS)]
            
            let result = try db?.selectSingleTable(select: testStatement)
            let result2 = try db?.selectSingleTable(select: SelectStatement(table: TestTable.self, columnNames: ["trainer"], whereAt: nil))
            
            for r in result! {
                let id = r["id"]! as! Int
                let trainer = r["trainer"] as! String
                print("\(id) \(trainer)")
            }
        } catch {
            
        }
    }
}
