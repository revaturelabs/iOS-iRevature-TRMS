//
//  MaintenanceReportViewController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class MaintenanceReportViewController: RevatureBaseViewController {
    
    @IBOutlet weak var reportTable: UITableView!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var roomID: UITextField!
    @IBOutlet weak var tableHeader: UIView!
    
//    let vcDateFormat = DateFormatter()
    let pickerDateFormat = DateFormatter()
    
    var filteredList: [Status] = [Status]()
    
    var rooms: [RoomName] = [RoomName]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rooms = RoomBusinessService.getAllRooms()

        
        tableHeader.layer.cornerRadius = 8
        tableHeader.layer.masksToBounds = true
        
        startDate.dateDropDown(dateFormat: "MMM dd, yy")
        endDate.dateDropDown(dateFormat: "MMM dd, yy")
        roomID.showDropDown(data: rooms.map{$0.name})
        
        roomID.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        startDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        endDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        
//        vcDateFormat.dateFormat = "MM-dd-yy"
        pickerDateFormat.dateFormat = "MMM dd, yy"
        
        reportTable.dataSource = self
        reportTable.delegate = self
    }
    
    @IBAction func emailReport() {
        showEmailComposer()
    }
    
}

extension MaintenanceReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let fromDate = pickerDateFormat.date(from: startDate.text!)!
        let toDate = pickerDateFormat.date(from: endDate.text!)!
        
        if let selectedRoom = rooms.first(where: {$0.name == roomID.text!}) {
            filteredList = ReportBusinessService.getAllReports(room: selectedRoom, fromDate: fromDate, toDate: toDate)
        }
        
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportTable.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportTableCell
        
        cell.dateLbl.text = filteredList[indexPath.row].roomName
        cell.trainerLbl.text = filteredList[indexPath.row].date.formatDate(by: "MMM dd, yy")
            
        
        if filteredList[indexPath.row].isClean {
            cell.completedLbl.text = "Cleaned"
        }
        else {
            cell.completedLbl.text = "Dirty"
        }
        
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = .white
        }
        else {
            cell.contentView.backgroundColor = UIColor(red: 242/255, green: 133/255, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var tasks = [TodayTask]()
        var message:String = ""
        
        let currentCell = tableView.cellForRow(at: indexPath) as! ReportTableCell
        let taskDate = pickerDateFormat.date(from: currentCell.trainerLbl.text!)!
        
        if let thisRoom = rooms.first(where: {$0.name == currentCell.dateLbl.text!}) {
            tasks = MaintenanceTaskBusinessService.getAllMaintenanceTasksByRoom(room: thisRoom, date: taskDate)
        }
        
        for task in tasks {
            let complete:String = task.completed ? "✓" : "×"
            message += "\(complete) \(task.name)\n"
        }
        
        if message == "" {
            message = "No details available"
        }
        
        Alert.showAlert(title: currentCell.dateLbl.text!, message: message, view: self, acceptButton: "Done")
    }
    
}

extension MaintenanceReportViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        reportTable.reloadData()
    }
}

