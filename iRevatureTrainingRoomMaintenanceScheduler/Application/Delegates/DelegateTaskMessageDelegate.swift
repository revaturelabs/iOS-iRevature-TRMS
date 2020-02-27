//
//  DelegateTaskMessageDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/25/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import MessageUI
import os.log


extension DelegateTaskViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //log user actions for email
        switch result {
        case .sent:
            os_log("Email sent")
        case .saved:
            os_log("Email saved")
        case .cancelled:
            os_log("Email cancelled")
        case.failed:
            os_log("Email failed")
        }
        //close email, return to previous screen
        controller.dismiss(animated:true)
    }
    
}

extension DelegateTaskViewController {
    
    
    func composeEmail(){
        let managerEmail:String = UserInfoBusinessService.getManagerEmail()
        
        //check if device has email or alert user to set up email
        guard MFMailComposeViewController.canSendMail() else {
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
    
    //function to create email body using user input
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
