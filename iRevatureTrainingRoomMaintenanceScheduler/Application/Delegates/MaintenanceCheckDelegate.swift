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
               
        cell.label.text = task.name

        cell.check.isOn = task.completed
        cell.check.tag = indexPath.row
        cell.check.addTarget(self, action: #selector(toggle), for: .valueChanged)
        
        return cell
               
    }
}


extension MaintenanceCheckController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! TaskSelectionCell
        
        data[indexPath.row].completed = !data[indexPath.row].completed
        
        cell.check.isOn = data[indexPath.row].completed
    }
    
    
    @objc func toggle(_ sender: UISwitch) {
        data[sender.tag].completed = sender.isOn
    }
    
}


