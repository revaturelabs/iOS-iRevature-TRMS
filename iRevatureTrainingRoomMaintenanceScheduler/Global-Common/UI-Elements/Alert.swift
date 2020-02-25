//
//  Alert.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func showTimedAlert(title: String, message: String, view: UIViewController, closeAfter: Double) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        view.present(alert, animated:true)
        
        let time = DispatchTime.now() + closeAfter
        DispatchQueue.main.asyncAfter(deadline: time) {
            alert.dismiss(animated:true, completion: nil)
        }
    }
    
}
