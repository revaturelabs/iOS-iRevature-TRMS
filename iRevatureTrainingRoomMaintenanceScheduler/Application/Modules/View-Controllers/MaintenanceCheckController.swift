//
//  MaintenanceCheckController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/15/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class MaintenanceCheckController: UIViewController {
    
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var selectorTextField: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    
    var roomList:[RoomName] = []
    var tasks:[MaintenanceTask] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomList = RoomBusinessService.getAllRooms()
        
        currentDate.text = Date().formatDate(by: "MMMM dd, yyyy")

        selectorTextField.showDropDown(data: ["Select room"] + roomList.map{$0.name})
        selectorTextField.addTarget(self, action: #selector(selectionChange(_:)), for: .allEditingEvents)
        
        self.taskTable.register(TaskSelectionCell.self, forCellReuseIdentifier: "TaskSelectionCell")
        self.taskTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        taskTable.dataSource = self
        taskTable.delegate = self
    }

    
    @IBAction func submitCheck(_ sender: Any) {
        let room = selectorTextField.text!
        
        MaintenanceTaskBusinessService.createMaintenanceTask(room: room, date: Date(), taskList: tasks)
        
    }
    
    @objc func selectionChange(_ textField: UITextField) {
        taskTable.reloadData()
    }
}


