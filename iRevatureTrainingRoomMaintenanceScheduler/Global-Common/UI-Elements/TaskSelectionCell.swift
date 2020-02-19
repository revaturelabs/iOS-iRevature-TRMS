//
//  TaskSelectionCell.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/16/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class TaskSelectionCell: UITableViewCell {

        weak var label: UILabel!
        weak var check: UISwitch!

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            self.initialize()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

            self.initialize()
        }

        func initialize() {

            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(label)
            self.label = label
            
            let check = UISwitch()
            check.translatesAutoresizingMaskIntoConstraints = false
            check.onTintColor = UIColor(red: 242/255, green: 133/255, blue: 0, alpha: 1)
            self.contentView.addSubview(check)
            self.check = check

            NSLayoutConstraint.activate([
                
                self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
                self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                
                self.check.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
                self.check.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                
            ])
            
            self.label.font = UIFont(name:"Helvetica", size: 18.0)
        }

        override func prepareForReuse() {
            super.prepareForReuse()

        }

}
