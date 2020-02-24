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
    
    let roomEndpoint = "https://private-dbd7b7-security14.apiary-mock.com/coredata/maintenance/tasks"

    func getTasks(_ completionHandler: @escaping (_ tasks:[JSONTask]) -> Void) {
        
        AF.request(
                   roomEndpoint,
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
