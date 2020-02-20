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
    @IBOutlet weak var trainerSelection: UITextField!
    
    
    
    var roomList = [String]()
    
    var trainerList = ["Uday", "Nick", "Bob"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomList = RoomBusinessService.getAllRoomNames()
        
        dateSelection.dateDropDown(dateFormat: "MMM dd, yy")
        roomSelection.showDropDown(data: roomList)
        trainerSelection.showDropDown(data: trainerList)

    }
    
}
