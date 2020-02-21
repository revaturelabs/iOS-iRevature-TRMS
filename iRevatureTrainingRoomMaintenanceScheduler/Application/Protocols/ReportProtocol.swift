//
//  ReportChartProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

protocol ReportProtocol {
    
    static func getAllReports() -> [Status]
    
    static func getAllReportsforUser(user:User) -> [Status]
    
}