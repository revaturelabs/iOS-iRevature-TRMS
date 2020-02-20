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
    
    var roomList:[String] = []
    var tasks:[MaintenanceTask] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = MaintenanceTaskBusinessService.getAllMaitenanceTasks()
        roomList = RoomBusinessService.getAllRoomNames()
        
        currentDate.text = Date().formatDate(by: "MMMM dd, yyyy")

        selectorTextField.showDropDown(data: roomList)
        
        self.taskTable.register(TaskSelectionCell.self, forCellReuseIdentifier: "TaskSelectionCell")
        self.taskTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        taskTable.dataSource = self
        taskTable.delegate = self
    }
    
//add dummy data for testing functionality
//    func setTasks() {
//        tasks.append(MaintenanceTask(id: 1, name: "Clean Desks", completed: false))
//        tasks.append(MaintenanceTask(id: 1, name: "Clean Whiteboards", completed: false))
//        tasks.append(MaintenanceTask(id: 1, name: "Arrange Desks", completed: false))
//        tasks.append(MaintenanceTask(id: 1, name: "Arrange Chairs", completed: false))
//        tasks.append(MaintenanceTask(id: 1, name: "Vacuum", completed: false))
//    }
    
    @IBAction func submitCheck(_ sender: Any) {
        let room = selectorTextField.text!
        
        MaintenanceTaskBusinessService.createMaitenanceTask(room: room, date: Date(), taskList: tasks)
        
    }
    

}
