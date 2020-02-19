//
//  DatePickerView.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class DatePickerView: UIDatePicker{
    
    var pickerTextField:UITextField!
    
    let format = DateFormatter()
    
    init(dropDownField: UITextField, dateFormat: String){
        super.init(frame: CGRect.zero)
        

        self.datePickerMode = .date
        self.timeZone = NSTimeZone.local
        
//        let calendar = Calendar(identifier: .gregorian)
//        var comps = DateComponents()
//        comps.month = 2
//        let maxDate = calendar.date(byAdding: comps, to: Date())
//        comps.month = -2
//        let minDate = calendar.date(byAdding: comps, to: Date())
//        self.maximumDate = maxDate
//        self.minimumDate = minDate
        
        self.format.dateFormat = dateFormat
        self.pickerTextField = dropDownField
        self.pickerTextField.text = format.string(from:self.date)
        self.pickerTextField.inputAccessoryView = OrangeToolbar(textField: pickerTextField)
        self.backgroundColor = UIColor.white
        
        self.addTarget(self, action: #selector(setDateThing), for: .valueChanged)
        
    }
    
    @objc func setDateThing() {
//        let format = DateFormatter()
//        format.dateFormat = "dd MMMM yy"
        self.pickerTextField.text = format.string(from:self.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

