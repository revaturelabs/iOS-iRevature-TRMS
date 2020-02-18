//
//  ViewController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/11/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testStuff()
    }

    @IBAction func openCheck(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "MaintenanceCheck", bundle: nil)
        let view = storyboard.instantiateInitialViewController()!
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated:true, completion: nil)
        
    }
    
}


