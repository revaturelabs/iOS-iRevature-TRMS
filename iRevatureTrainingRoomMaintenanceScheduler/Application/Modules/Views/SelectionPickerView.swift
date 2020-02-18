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
    
    init(pickerData: [String], dropDownField: UITextField){
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropDownField
        self.pickerTextField.inputAccessoryView = setToolBar()
        self.backgroundColor = UIColor.white
        
        self.delegate = self
        self.dataSource = self
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return columnInt
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
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
