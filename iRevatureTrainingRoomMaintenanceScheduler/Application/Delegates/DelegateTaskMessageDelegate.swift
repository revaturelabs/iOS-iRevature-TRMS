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
        let managerEmail:String = UserInfoBusinessService.getManagerEmail()

        
        guard MFMailComposeViewController.canSendMail() else {
            //alert
            Alert.showAlert(title: "No email", message: "Please set up email on your device", view: self, acceptButton: "Okay")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([managerEmail])
        composer.setSubject("Training Room Check List Switch Request")
        composer.setMessageBody(createMessage(), isHTML: false)
        
        present(composer, animated:true)
        
    }
    
    func createMessage() -> String {
        
        let trainingRoom = roomSelection.text!
        let date = dateSelection.text!
        let text = reasonTextView.text!
        
        let message = """
        Please schedule a trainer to complete the following check list:
        
        Date:       \(date)
        Room:       \(trainingRoom)
        Reason:     \(text)
        """
        
        return message
    }
}
