//
//  RevatureOrangeButton.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/14/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class RevatureButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    func setupButton(){
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor(red: 242/255, green: 133/255, blue: 0, alpha: 1)
        layer.cornerRadius = 5
        titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        widthAnchor.constraint(equalToConstant: 288).isActive = true
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    override var isEnabled: Bool {
        didSet {
            if !self.isEnabled {
                self.alpha = 0.5
            } else {
                self.alpha = 1
            }
        }
    }
}
