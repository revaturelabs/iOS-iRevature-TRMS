//
//  DDMFunctions.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/13/20.
//  Copyright © 2020 revature. All rights reserved.
//

import SQLite3

extension DatabaseAccess {
//===============================================================================================
    //Insert into table
//===============================================================================================
    func insertRow (statement: InsertStatement) throws {
        if (statement.getTable().getColumnsCount() != statement.getColumnValuesCount()) {
            throw SQLiteError.Insert(message: "Incorrect number of values for columns")
        }

        //Prepare the SQL statement
        guard let statement = statement.makeStatement() else {
            throw SQLiteError.Insert(message: "Unable to prepare insert statement")
        }

        let insertStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)

        //Run after function finished to destroy statement
        defer {
            sqlite3_finalize(insertStatement)
        }

        //Run the SQL statement
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Insert(message: String(cString: sqlite3_errmsg(insertStatement)))
        }
    }

//===============================================================================================
    //Update Table Row
//===============================================================================================
    func updateRow(statement: UpdateStatement) throws {
//        guard update.whereAt != nil && update.table.columns.count >= update.whereAt!.count else {
//            throw SQLiteError.Update(message: "Where statement is not valid")
//        }
//
//        //Check to make sure that the amount of data matches the table
//        if update.table.columns.count < update.set.count {
//            throw SQLiteError.Update(message: "Set statement is not valid")
//        }

        //Prepare the SQL statement
        guard let statement = statement.makeStatement() else {
            throw SQLiteError.Update(message: "Unable to prepare update")
        }
        
        let updateStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)

        //Call after function to destroy statement
        defer {
            sqlite3_finalize(updateStatement)
        }

        //Run the SQL statement
        guard sqlite3_step(updateStatement) == SQLITE_DONE else {
            throw SQLiteError.Update(message: String(cString: sqlite3_errmsg(updateStatement)))
        }
    }
}
////===============================================================================================
//    //Delete Row From Table
////===============================================================================================
//    func deleteRow(delete: DeleteStatement) throws {
//
//        //Check to make sure that the amount of data matches the table
//        guard delete.whereAt != nil && delete.table.columns.count < delete.whereAt!.count else {
//            throw SQLiteError.Update(message: "Where statement is not valid")
//        }
//
//        //Prepare the SQL statement
//        let atString = try LeStatement.makeWhereStatement(table: delete.table, at: delete.whereAt!)
//
//        let statement = "\(SQLiteKeyword.DELETE) \(SQLiteKeyword.FROM) \(delete.table) \(atString);"
//        let deleteStatement = try prepareStatement(sqlStatement: statement, statementType: .prepare_v2)
//
//        print(statement)
//
//        //Call after function to destroy statement
//        defer {
//            sqlite3_finalize(deleteStatement)
//        }
//
//        //Run the SQL statement
//        guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
//            throw SQLiteError.Update(message: String(cString: sqlite3_errmsg(deleteStatement)))
//        }
//    }
//}
