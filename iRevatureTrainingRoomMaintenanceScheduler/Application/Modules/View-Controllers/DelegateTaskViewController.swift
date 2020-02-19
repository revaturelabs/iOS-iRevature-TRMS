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
    
    
    
    var roomList = ["NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338", "NEC 107", "NEC 200", "NEC 300", "NEC 320", "NEC 338"]
    
    var trainerList = ["Uday", "Nick", "Bob"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dateSelection.dateDropDown()
        roomSelection.showDropDown(data: roomList)
        trainerSelection.showDropDown(data: trainerList)
        

        // Do any additional setup after loading the view.
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
