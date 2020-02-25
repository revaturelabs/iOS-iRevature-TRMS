//
//  DelegateTaskViewController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/18/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class DelegateTaskViewController: UIViewController {
    
    @IBOutlet weak var dateSelection: UITextField!
    @IBOutlet weak var roomSelection: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    
    
    var roomList = [RoomName]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomList = RoomBusinessService.getAllRooms()
        
        dateSelection.dateDropDown(dateFormat: "MMM dd, yy")
        roomSelection.showDropDown(data: roomList.map{$0.name})
    
    }
    
    @IBAction func assignTask(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yy"
        let date = formatter.date(from: dateSelection.text!)!
        
    }
}
