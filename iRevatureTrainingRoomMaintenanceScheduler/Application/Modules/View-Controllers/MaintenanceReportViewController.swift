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
    var roomList: [Status] = [Status]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomList = ReportBusinessService.getAllReportsforUser(user: User(id: 1, email: "", name: "", role: "", token: "", keepLoggedIn: true))
        
        tableHeader.layer.cornerRadius = 8
        tableHeader.layer.masksToBounds = true
        
        startDate.dateDropDown(dateFormat: "MMM dd, yy")
        endDate.dateDropDown(dateFormat: "MMM dd, yy")
        roomID.showDropDown(data: RoomBusinessService.getAllRoomNames())
        
        roomID.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        startDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        endDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        
//        vcDateFormat.dateFormat = "MM-dd-yy"
        pickerDateFormat.dateFormat = "MMM dd, yy"
        
        reportTable.dataSource = self
        reportTable.delegate = self
    }
    
    @IBAction func emailReport() {
        return
    }
    
}

extension MaintenanceReportViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.removeAll()
        
        for room in roomList {
            if room.roomName == roomID.text &&
               room.date <= pickerDateFormat.date(from: endDate.text!)! &&
               room.date >= pickerDateFormat.date(from: startDate.text!)! {
                
                filteredList.append(room)
            }
        }
        
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportTable.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportTableCell
        
        cell.dateLbl.text = filteredList[indexPath.row].roomName
        cell.trainerLbl.text = filteredList[indexPath.row].date.formatDate(by: "MM-dd-yy")
            
        
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
    
}

extension MaintenanceReportViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        reportTable.reloadData()
    }
}

