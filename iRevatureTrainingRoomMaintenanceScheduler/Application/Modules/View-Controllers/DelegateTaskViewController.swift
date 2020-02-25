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
    
    
    
    var roomList = [RoomName]()
    
    var trainerList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomList = RoomBusinessService.getAllRooms()
        trainerList = TrainerBusinessService.getAllTrainerNames()
        
        dateSelection.dateDropDown(dateFormat: "MMM dd, yy")
        roomSelection.showDropDown(data: roomList.map{$0.name})
        trainerSelection.showDropDown(data: trainerList)

    }
    
    @IBAction func assignTask(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yy"
        let date = formatter.date(from: dateSelection.text!)!
        
        DelegateTaskBusinessService.createNewTaskDelegation(room: roomSelection.text!, date: date, trainer: trainerSelection.text!)
    }
}
