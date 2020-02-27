//
//  MaintenanceReportMessageDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import MessageUI
import os.log

extension MaintenanceReportViewController: MFMailComposeViewControllerDelegate {
    
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

extension MaintenanceReportViewController {
   
    
    func showEmailComposer(){
        //get the email for current user's manager
        let managerEmail = UserInfoBusinessService.getManagerEmail()
        //check if user had email set up, show alert if not set up
        guard MFMailComposeViewController.canSendMail() else {
            Alert.showAlert(title: "No email", message: "Please set up email on your device", view: self, acceptButton: "Okay")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([managerEmail])
        composer.setSubject("Training Room Report")
        composer.setMessageBody(createMessage(), isHTML: true)
        
        present(composer, animated:true)
        
    }
    
    //function to create an HTML table using the status of a room
    func createMessage() -> String {
        let preRows = """
            <table cellpadding="5" border="1">
            <thead>
                <th>Room</th>
                <th>Date</th>
                <th>Status</th>
            </thead>
            <tbody>
        """
        let rows = filteredList.map{"""
            <tr>
                <td> \($0.roomName)</td>
                <td> \($0.date.formatDate(by: "MMM dd, yyyy")) </td>
                <td> \($0.isClean ? "clean" : "dirty")</td>
            </tr>
            """
            }.reduce("", +)
        let postRows = "</tbody></table>"
        let html = preRows + rows + postRows
        return html
    }
    
}
