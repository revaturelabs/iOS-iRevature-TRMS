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
    
    //set up number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //filter out rooms from tasks that do not match the selected room
        tasksForRoom = tasks.filter{$0.room.name == selectorTextField.text!}
        
        return self.tasksForRoom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //make cells that match the TaskSelectionCell and imput data
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskSelectionCell", for: indexPath) as! TaskSelectionCell
        
        let task = tasksForRoom[indexPath.row]
               
        cell.label.text = task.name

        cell.check.isOn = task.completed
        cell.check.tag = indexPath.row
        //add function to update state of UISwitch
        cell.check.addTarget(self, action: #selector(toggle), for: .valueChanged)
        
        return cell
               
    }
}


extension MaintenanceCheckController: UITableViewDelegate {
    
    //set table height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //handle interaction with table row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! TaskSelectionCell
        
        tasksForRoom[indexPath.row].completed = !tasksForRoom[indexPath.row].completed
        
        //update UISwitch when row is touched, animate the movement
        cell.check.setOn(tasksForRoom[indexPath.row].completed, animated: true)
    }
    
    
    //update the TaskRoomArray to match the UISwitch isOn value
    @objc func toggle(_ sender: UISwitch) {
        tasksForRoom[sender.tag].completed = sender.isOn
    }
    
}


