//
//  ReportTableCell.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import Foundation

class ReportTableCell: RevatureBaseTableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var trainerLbl: UILabel!
    @IBOutlet weak var completedLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
