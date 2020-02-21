//
//  MaintenanceReportMessageDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/20/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import MessageUI

extension MaintenanceReportViewController: MFMailComposeViewControllerDelegate {
    
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

extension MaintenanceReportViewController {
    
    func showEmailComposer(){
        guard MFMailComposeViewController.canSendMail() else {
            //alert
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("Training Room Report")
        composer.setMessageBody(createMessage(), isHTML: true)
        
        present(composer, animated:true)
        
    }
    
    func createMessage() -> String {
        let preRows = "<table cellpadding=\"5\" border=\"1\"><thead><th>Room</th><th>Date</th><th>Status</th></thead><tbody>"
        let rows = filteredList.map{"<tr><td> \($0.roomName)</td><td> \($0.date.formatDate(by: "MMM dd, yyyy")) </td><td> \($0.isClean ? "clean" : "dirty")</td></tr>"}.reduce("", +)
        let postRows = "</tbody></table>"
        let html = preRows + rows + postRows
        return html
    }
    
}
