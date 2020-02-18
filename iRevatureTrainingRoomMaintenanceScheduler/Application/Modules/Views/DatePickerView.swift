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
    
    init(dropDownField: UITextField){
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
        
        self.pickerTextField = dropDownField
        self.pickerTextField.inputAccessoryView = setToolBar()
        self.backgroundColor = UIColor.white
        
        self.addTarget(self, action: #selector(setDateThing), for: .valueChanged)
        
    }
    
    @objc func setDateThing() {
        let format = DateFormatter()
        format.dateFormat = "dd MMM"
        self.pickerTextField.text = format.string(from:self.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEdit))
        button.tintColor = UIColor.white
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!], for: .normal)

        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.barTintColor = UIColor(red: 242/255, green: 133/255, blue: 0, alpha: 1)
        
        return toolbar
    }
    
    @objc func endEdit(){
        pickerTextField.endEditing(true)
    }
}

