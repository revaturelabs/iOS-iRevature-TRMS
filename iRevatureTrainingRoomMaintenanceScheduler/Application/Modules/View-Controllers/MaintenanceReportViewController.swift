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
    
    let vcDateFormat = DateFormatter()
    let pickerDateFormat = DateFormatter()
    
    var filteredList: [(roomID: String, maintenanceDate: String, isClean: Bool)] = [(roomID: String, maintenanceDate: String, isClean: Bool)]()
    var roomList: [(roomID: String, maintenanceDate: String, isClean: Bool)] = [
        ("NEC 200", "02-01-20", true),
        ("NEC 200", "02-02-20", true),
        ("NEC 200", "02-03-20", true),
        ("NEC 200", "02-04-20", false),
        ("NEC 200", "02-05-20", true),
        ("NEC 200", "02-06-20", true),
        ("NEC 200", "02-05-20", true),
        ("NEC 200", "02-07-20", false),

        ("NEC 300", "02-01-20", true),
        ("NEC 300", "02-02-20", false),
        ("NEC 300", "02-03-20", true),
        ("NEC 300", "02-04-20", true),
        ("NEC 300", "02-05-20", true),
        ("NEC 300", "02-06-20", true),
        ("NEC 300", "02-05-20", true),
        ("NEC 300", "02-07-20", true),

        ("NEC 320", "02-01-20", true),
        ("NEC 320", "02-02-20", true),
        ("NEC 320", "02-03-20", true),
        ("NEC 320", "02-04-20", false),
        ("NEC 320", "02-05-20", false),
        ("NEC 320", "02-06-20", true),
        ("NEC 320", "02-05-20", true),
        ("NEC 320", "02-07-20", true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHeader.layer.cornerRadius = 8
        tableHeader.layer.masksToBounds = true
        
        startDate.dateDropDown(dateFormat: "MMM dd, yy")
        endDate.dateDropDown(dateFormat: "MMM dd, yy")
        roomID.showDropDown(data: ["NEC 200", "NEC 300", "NEC 320"])
        
        roomID.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        startDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        endDate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        
        vcDateFormat.dateFormat = "MM-dd-yy"
        pickerDateFormat.dateFormat = "MMM dd, yy"
        
        reportTable.dataSource = self
        reportTable.delegate = self
    }
    
    @IBAction func emailReport() {
        return
    }
    
}

extension MaintenanceReportViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.removeAll()
        
        for room in roomList {
            if room.roomID == roomID.text &&
                vcDateFormat.date(from: room.maintenanceDate)! <= pickerDateFormat.date(from: endDate.text!)! &&
                vcDateFormat.date(from: room.maintenanceDate)! >= pickerDateFormat.date(from: startDate.text!)! {
                
                filteredList.append(room)
            }
        }
        
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reportTable.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportTableCell
        
        cell.dateLbl.text = filteredList[indexPath.row].roomID
        cell.trainerLbl.text = filteredList[indexPath.row].maintenanceDate
            
        
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

