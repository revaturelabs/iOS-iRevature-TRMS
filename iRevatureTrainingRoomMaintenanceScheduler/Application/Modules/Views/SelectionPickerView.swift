//
//  DropDownPickerView.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/11/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import UIKit


class DropDownPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var pickerData:[String]!
    var pickerTextField:UITextField!
    var columnInt:Int {
        return 1
    }
    
    //set up picker using array and textfield
    init(pickerData: [String], dropDownField: UITextField){
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropDownField
        
        //set up look of picker view
        self.pickerTextField.inputAccessoryView = OrangeToolbar(textField: pickerTextField)
        self.backgroundColor = UIColor.white
        
        self.delegate = self
        self.dataSource = self
        
        //disable picker if there is no data
        DispatchQueue.main.async(execute: {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return columnInt
    }
    
    //number of items in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //get information for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //update textfield to match row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
}
