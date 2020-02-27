//
//  UserStatements.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

extension UserTable {
    static func getAllStatement() -> SelectStatement {
        var selectStatement = SelectStatement()
        selectStatement.specifyColumn(table: table, columnName: ColumnName.id.rawValue, asName: ColumnName.id.rawValue)
        selectStatement.specifyColumn(table: table, columnName: ColumnName.apiID.rawValue, asName: ColumnName.apiID.rawValue)
        selectStatement.specifyColumn(table: table, columnName: ColumnName.name.rawValue, asName: ColumnName.name.rawValue)
        
        return selectStatement
    }
    
    static func insertStatement(userApiID: String, userName: String, userLocation: Int) -> InsertStatement {
        var insertStatement = InsertStatement(table: table)
        insertStatement.specifyValue(columnName: ColumnName.apiID.rawValue, columnValue: userApiID)
        insertStatement.specifyValue(columnName: ColumnName.name.rawValue, columnValue: userName)
        insertStatement.specifyValue(columnName: ColumnName.locationID.rawValue, columnValue: userLocation)
        
        return insertStatement
    }
    
    static func getByApiIDStatement(userApiID: String) -> SelectStatement {
        var selectUser = SelectStatement()
        addSelectColumns(toStatement: &selectUser, withColumnNames: .id, .apiID, .name, .locationID)
        
        var whereStatement = WhereStatement()
        whereStatement.addStatement(table: table, columnName: ColumnName.apiID.rawValue, expression: .EQUALS, columnValue: userApiID.trimmingCharacters(in: .whitespacesAndNewlines))
        
        selectUser.setWhereStatement(statement: whereStatement)
        
        return selectUser
    }
}
