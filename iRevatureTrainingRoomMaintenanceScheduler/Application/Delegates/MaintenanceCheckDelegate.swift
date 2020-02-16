//
//  MaintenanceCheckDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/16/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import UIKit

extension MaintenanceCheckController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskSelectionCell", for: indexPath) as! TaskSelectionCell
        let task = data[indexPath.row]
               
        cell.label.text = task.0


        cell.check.isOn = task.1
//        switchSelector.tag = indexPath.row
//        switchSelector.addTarget(self, action: #selector(toggle), for: .valueChanged)
        
        return cell
               
    }
}


extension MaintenanceCheckController: UITableViewDelegate {
    
}
