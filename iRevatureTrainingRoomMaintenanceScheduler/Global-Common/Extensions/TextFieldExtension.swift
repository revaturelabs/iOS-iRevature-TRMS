//
//  textFieldExtension.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/12/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func showDropDown(data: [String]){
        self.inputView = DropDownPickerView(pickerData: data, dropDownField: self)
    }
    
    func dateDropDown(dateFormat: String){
        let datePicker = DatePickerView(dropDownField: self, dateFormat: dateFormat)
        self.inputView = datePicker
    }
}
