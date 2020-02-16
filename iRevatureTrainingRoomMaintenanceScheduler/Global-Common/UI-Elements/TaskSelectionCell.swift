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

                self.contentView.leadingAnchor.constraint(equalTo: self.label.leadingAnchor, constant: -20),
                self.contentView.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
                
                self.contentView.trailingAnchor.constraint(equalTo: self.check.trailingAnchor, constant: 20),
                self.contentView.centerYAnchor.constraint(equalTo: self.check.centerYAnchor)
            ])
            
            self.label.font = UIFont(name:"Helvetica", size: 18.0)
        }

        override func prepareForReuse() {
            super.prepareForReuse()

        }

}
