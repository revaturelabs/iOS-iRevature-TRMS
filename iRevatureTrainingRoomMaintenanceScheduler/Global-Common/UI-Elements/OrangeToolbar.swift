//
//  OrangeToolbar.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class OrangeToolbar: UIToolbar {
    
    init(){
        
        self.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEdit))
        button.tintColor = UIColor.white
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!], for: .normal)
        
        
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
