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
    
    //set up date picker using a format
    init(dropDownField: UITextField, dateFormat: String){
        super.init(frame: CGRect.zero)
        
        //set picker mode to be a date using devices timezone
        self.datePickerMode = .date
        self.timeZone = NSTimeZone.local
        
//        //set constraints to date picker
//        let calendar = Calendar(identifier: .gregorian)
//        var comps = DateComponents()
//        comps.month = 2
//        let maxDate = calendar.date(byAdding: comps, to: Date())
//        comps.month = -2
//        let minDate = calendar.date(byAdding: comps, to: Date())
//        self.maximumDate = maxDate
//        self.minimumDate = minDate
        
        //set up date format and populate text field with date
        self.format.dateFormat = dateFormat
        self.pickerTextField = dropDownField
        self.pickerTextField.text = format.string(from:self.date)
        //set up look of picker view
        self.pickerTextField.inputAccessoryView = OrangeToolbar(textField: pickerTextField)
        self.backgroundColor = UIColor.white
        
        //handle change of text field
        self.addTarget(self, action: #selector(setDateThing), for: .valueChanged)
        
    }
    
    //update text field being changed
    @objc func setDateThing() {
        self.pickerTextField.text = format.string(from:self.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

