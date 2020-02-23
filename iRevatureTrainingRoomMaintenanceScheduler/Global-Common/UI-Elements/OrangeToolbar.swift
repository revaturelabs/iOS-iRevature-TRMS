//
//  OrangeToolbar.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class OrangeToolbar: UIToolbar {
    
    var textField:UITextField!
    
    init(textField: UITextField){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.textField = textField
        
        self.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEdit))
        button.tintColor = UIColor.white
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!], for: .normal)
        
        self.setItems([button], animated: true)
        self.isUserInteractionEnabled = true
        self.barTintColor = UIColor(red: 242/255, green: 133/255, blue: 0, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func endEdit(){
        textField.endEditing(true)
    }

}
