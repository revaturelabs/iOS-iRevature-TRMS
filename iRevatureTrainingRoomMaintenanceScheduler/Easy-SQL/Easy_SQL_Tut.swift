//
//  Easy_SQL_Tut.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

struct Table {
    static var WesTable: SQLiteTable {
        var wesTable = SQLiteTable(tableName: "WesTable")
        wesTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        wesTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        return wesTable
    }
    
    static var MarkTable: SQLiteTable {
        var markTable = SQLiteTable(tableName: "MarkTable")
        markTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        markTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)
        
        return markTable
    }
    
    static var BoolTableTest: SQLiteTable {
        var boolTable = SQLiteTable(tableName: "BoolTableTest")
        boolTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        boolTable.addColumn(columnName: "name", dataType: .CHAR, constraints: .NOTNULL)
        boolTable.addColumn(columnName: "bool", dataType: .BOOL, constraints: .NOTNULL)
        
        return boolTable
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
        
    //Returns a 2d array of data : [Row][Column]
        //db?.selectData(statement: <#T##SelectStatement#>)
        
//=================================
        //Statements
        //When making a statement, if it returns nil, the  statement has an error and was unable to be constructed
        //This is most likely due to a mismatch between the table columns and statements (Such as insert)
        //If for any reason the statements are continually returning nil when you know it is right,
        //you will need to restart Xcode
//=================================
        
//---------------------------------
        //Table creation
        
        //Setup
            //Instantiate
            //Add Columns
        
        //Parameters
            //Init
                //tableName (String) : Name the the table should be in the database
            
            //addColumn
                //columnName (String) : Name of the column to add in table
                //dataType (SQLiteDataType) : Specifies what the datatype it is using should be
                //constraints (SQLiteConstraints?) : apply any number of constraints to column; Assign 'nil' if there should be none
//---------------------------------
        var wesTable = SQLiteTable(tableName: "WesTable")
        wesTable.addColumn(columnName: "id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        wesTable.addColumn(columnName: "name", dataType: .CHAR, constraints: nil)

        
//---------------------------------
        //Where statement
        
        //Setup
            //Instantiate
            //Add statements
        
        //Parameters
            //table (SQLiteTable) : The table reference that the 'columnName' is a part of
            //clause (SQLiteClause) : (Optionial) only ommit on first add; determins how the statement will interact with the one added before it
            //columnName (String) : reference to the column from the 'table'
            //expression (SQLiteExpression) : how the 'columnValue' should compare to the other values in the table from 'columnName'
            //columnValue (Any...) : value that will compare to the other rows
//---------------------------------
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: wesTable, columnName: "name", expression: .EQUALS, columnValue: "Wes")
        whereStatement.addStatement(table: wesTable, clause: .OR, columnName: "name", expression: .EQUALS, columnValue: "Mark")
        whereStatement.addStatement(table: wesTable, columnName: "id", expression: .BETWEEN, columnValue: 5, 12)

        
//---------------------------------
        //nsert statement
        
        //Setup
            //Instantiate
        
        //Parameters
            //Init
                //table (SQLiteTable) : Reference to a table
                //columnValues (Any...) : insert values that reflect the 'table' being referenced
//---------------------------------
        let insertStatement = InsertStatement(table: wesTable, columnValues: 53, "Katelyn")

        
//---------------------------------
        //Update statement
        
        //Setup
            //Instantiate
            //Add Value Changes
            //Set Where Statement
        
        //Parameters
            //Init
                //table (SQLiteTable) : Reference for columns
        
            //addValueChange
                //columnToUpdate (String) : Name of the column in the table that is to be updated
                //updatedValue (Any) : The new value to be place in the repsective column
        
            //setWhereStatement
                //statement (WhereStatement) : assign a where statement that will allow the update to occur at specific locations
//---------------------------------
        var updateStatement = UpdateStatement(table: wesTable)
        updateStatement.addValueChange(columnToUpdate: "name", updatedValue: "Mark")
        updateStatement.setWhereStatement(statement: whereStatement)


//---------------------------------
        //Delete statement
        
        //Setup
            //Instantiate
        
        //Parameters
            //Init
                //table (SQLiteTable) : Reference for columns
        
            //setWhereStatement
                //statement (WhereStatement) : assign a where statement that will allow the delete to occur at specific locations
//---------------------------------
        var deleteStatement = DeleteStatement(table: wesTable)
        deleteStatement.setWhereStatement(statement: whereStatement)
        

//---------------------------------
        //Join statement
        
        //Setup
            //Instantiate
        
        //Parameters
            //Init
                //table1 (SQLiteTable) : Reference for 'onColumnName1' and the table to be joined into
                //joinType (SQLiteJoin) : how the two tables will combine together based on the data
                //table2 (SQLiteTable) : Reference for 'onColumnName2'
                //onColumnName1 (String) : column from table 1 to compare with the column from table 2
                //onColumnName2 (String) : column from table 2 to compare with the column from table 1
        
            //appendJoin
                //joinType (SQLiteJoin) : How the last most joined table will join with the new one
                //table (SQLiteTable) : Table to join with the last one added
                //onPreviousTableColumnName (String) : name of the column from the last added table to compare with
                //onThisTableColumnName (String) : name of the column to compare with the last added table
//---------------------------------
        var joinStatement = JoinStatement(table1: wesTable, joinType: .INNER, table2: wesTable, onColumnName1: "name", onColumnName2: "name")
        
        joinStatement.appendJoin(joinType: .INNER, table: wesTable, onPreviousTableColumnName: "id", onThisTableColumnName: "id")

        
//---------------------------------
        //Select statement
        
        //Setup
            //Instantiate
            //Specify Columns
            //Add Join Statement (Optional - Requires a WhereStatement if added)
            //Add Where Statement (Optional)
        
        //Parameters
            //specifyColumn
                //table (SQLiteTable) : Table reference to get data from
                //columnName (String) : Column name that references the table
                //asName (String) : Alias that will be given on return of data
        
            //setJoinStatement
                //statement (JoinStatement) : assign to select from a single combined table
        
            //setWhereStatement
                //statement (WhereStatement) : assign a where statement that will find data at specific locations
//---------------------------------
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: wesTable, columnName: "name", asName: "Person")
        selectStatement.setJoinStatement(statement: joinStatement)
        selectStatement.setWhereStatement(statement: whereStatement)

    }
}

//Iterate through a result from database select
//Result string is not necessary, choose how to handle the data instead. Such as assigning the data to a [struct]
//
//        do {
//
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
