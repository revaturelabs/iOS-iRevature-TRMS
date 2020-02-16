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
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var taskTable: UITableView!
    
    var roomList = ["NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338", "NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338"]
    var data = [("Clean whiteboards", false), ("Arrange desks", false), ("Clean desks", false), ("Push in chairs", false), ("Unplug power strips", false), ("Vacuum carpets", false), ("Turn off computer", false), ("Turn off projector", false), ("Turn off lights", false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MMMM dd, yyyy"
        let formattedDate = format.string(from: date)
        currentDate.text = formattedDate

        selectorTextField.showDropDown(data: roomList)
        
        self.taskTable.register(TaskSelectionCell.self, forCellReuseIdentifier: "TaskSelectionCell")
        self.taskTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        taskTable.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
