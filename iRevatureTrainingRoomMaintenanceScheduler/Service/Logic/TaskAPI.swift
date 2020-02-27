//
//  TaskAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/24/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class TaskAPI: API {
    
    var endpoint = "https://private-dbd7b7-security14.apiary-mock.com/coredata/maintenance/tasks"
    
    //function to get tasks can take nil for all task or a roomID string for tasks for room
    func getTasks(_ roomID: String?, _ completionHandler: @escaping (_ tasks:[JSONTask]) -> Void) {
        
        //change endpoint if roomID string is provided
        if roomID != nil {
            let url = "https://private-dbd7b7-security14.apiary-mock.com/coredata/maintenance/room/tasks/"
            endpoint = url + roomID!
        }
        
        AF.request(
                   endpoint,
                   headers: header
        ).validate().responseDecodable(of: APITaskResponse.self){
            (response) in
            guard let data = response.value else {
                print("Error appeared")
                print(response.error?.errorDescription! ?? "Unknown error found")
                return
            }
            
            completionHandler(data.tasks)
        }
        
    }
    
}
