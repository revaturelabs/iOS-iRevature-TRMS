//
//  DelegateTaskMessageDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import MessageUI


extension DelegateTaskViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .sent:
            print("sent")
        case .saved:
            print("saved")
        case .cancelled:
            print("cancelled")
        case.failed:
            print("failed")
        }
        
        controller.dismiss(animated:true)
    }
    
}

extension DelegateTaskViewController {
    
    func composeEmail(){
        guard MFMailComposeViewController.canSendMail() else {
            //alert
            Alert.showAlert(title: "No email", message: "Please set up email on your device", view: self, acceptButton: "Okay")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("Request to pass on training room maintenance check")
        composer.setMessageBody(createMessage(), isHTML: false)
        
        present(composer, animated:true)
        
    }
    
    func createMessage() -> String {
        
        let trainingRoom = roomSelection.text!
        let date = dateSelection.text!
        let text = reasonTextView.text!
        
        let message = """
            Please assign the following to another trainer:
            Room: \(trainingRoom)
            Date: \(date)
            Reason: \(text)
        """
        
        return message
    }
}
