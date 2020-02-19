//
//  MaintenanceCheckController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/15/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class MaintenanceCheckController: UIViewController {
    
    @IBOutlet weak var selectorTextField: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    
    var roomList = ["NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338", "NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338"]
    var tasks:[MaintenanceTask] = [MaintenanceTask]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTasks()
        
//        let date = Date()
//        let format = DateFormatter()
//        format.dateFormat = "MMMM dd, yyyy"
//        let formattedDate = format.string(from: date)
//        currentDate.text = formattedDate

        selectorTextField.showDropDown(data: roomList)
        
        self.taskTable.register(TaskSelectionCell.self, forCellReuseIdentifier: "TaskSelectionCell")
        self.taskTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        taskTable.dataSource = self
        taskTable.delegate = self
    }
    
//add dummy data for testing functionality
    func setTasks() {
        tasks.append(MaintenanceTask(id: 1, name: "Clean Desks", completed: false))
        tasks.append(MaintenanceTask(id: 1, name: "Clean Whiteboards", completed: false))
        tasks.append(MaintenanceTask(id: 1, name: "Arrange Desks", completed: false))
        tasks.append(MaintenanceTask(id: 1, name: "Arrange Chairs", completed: false))
    }
    
    @IBAction func submitCheck(_ sender: Any) {
        
        for task in tasks {
            print("\(task.name) is completed: \(task.completed)")
        }
    
    }
    

}
