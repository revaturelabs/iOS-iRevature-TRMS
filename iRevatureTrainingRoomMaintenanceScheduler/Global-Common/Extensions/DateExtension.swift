//
//  DateExtension.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/19/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation


extension Date {
    func formatDate(by: String) -> String {
        let format = DateFormatter()
        format.dateFormat = by
        let formattedDate = format.string(from: self)
        return formattedDate
    }
}
