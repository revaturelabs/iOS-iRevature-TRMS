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
    
    func dateDropDown(){
        self.inputView = DatePickerView(dropDownField: self)
    }
}
