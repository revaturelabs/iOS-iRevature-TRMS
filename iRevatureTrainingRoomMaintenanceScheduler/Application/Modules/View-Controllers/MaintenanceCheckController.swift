//
//  MaintenanceCheckController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/15/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import os.log

class MaintenanceCheckController: UIViewController {
    
    @IBOutlet weak var selectorTextField: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var submitButton: RevatureButton!
    @IBOutlet weak var dateSelector: UITextField!
    
    let dateFormat = DateFormatter()
    var selectedDate = Date()
    
    var dates: [Date] = []
    var roomList:[RoomName] = []
    var tasks:[TodayTask] = []
    var tasksForRoom:[TodayTask] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...6 {
            dates.append(Date(timeIntervalSinceNow: -86400*Double(i)))
        }
        
        roomList = RoomBusinessService.getAllRooms()
        
        tasks = MaintenanceTaskBusinessService.getAllTasksForDay(date: Date())
        
        submitButton.isEnabled = false
        
        dateSelector.showDropDown(data: dates.map{$0.formatDate(by: "MMMM dd, yyyy")})
        
        selectorTextField.showDropDown(data: ["Select room"] + roomList.map{$0.name})
        
        selectorTextField.addTarget(self, action: #selector(selectionChange(_:)), for: .allEditingEvents)
        dateSelector.addTarget(self, action: #selector(dateChange(_:)), for: .editingDidEnd)
        
        self.taskTable.register(TaskSelectionCell.self, forCellReuseIdentifier: "TaskSelectionCell")
        self.taskTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        dateFormat.dateFormat = "MMMM dd, yyyy"
        
        taskTable.dataSource = self
        taskTable.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5) {
            self.setManagerEmail()
        }
    }

    
    @IBAction func submitCheck(_ sender: Any) {
        guard let room = roomList.first(where: {$0.name == selectorTextField.text!}) else {
            return
        }
        
        if MaintenanceTaskBusinessService.createMaintenanceTask(room: room, date: Date(), taskList: tasksForRoom) {
        
            Alert.showTimedAlert(title: "Success", message: "Checklist for \(room.name) has been submitted", view: self, closeAfter: 1)
        } else {
            Alert.showAlert(title: "Error", message: "Unable to submit checklist", view: self, acceptButton: "Okay")
        }
        
        self.updateTasks(date: selectedDate)
        
    }
    
    func updateTasks(date: Date){
        self.tasks = []
        self.tasks = MaintenanceTaskBusinessService.getAllTasksForDay(date: date)
    }
    
    
    @objc func selectionChange(_ textField: UITextField) {
        taskTable.reloadData()
        if selectorTextField.text! != "Select room" {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    @objc func dateChange(_ textField: UITextField) {
        self.selectedDate = self.dateFormat.date(from: self.dateSelector.text!)!
        tasks = MaintenanceTaskBusinessService.getAllTasksForDay(date: self.selectedDate)
        taskTable.reloadData()
    }
    
    
    func setManagerEmail(){
        var user = UserInfoBusinessService.getUserInfo()
        //make call to trainer api endpoint
        let trainerapi = TrainerAPI()
        trainerapi.getTrainers { (trainers) in
            let current = trainers.first(where: {$0.id == user?.empID})
            user?.managerEmail = current?.manager_email
            user?.name = current!.name
            if UserInfoBusinessService.setUserInfo(userObject: user!) {
                os_log("User updated")
            }
        }

    }
}


