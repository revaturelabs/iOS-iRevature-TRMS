//
//  LocationAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/27/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class LocationAPI: API {
    
       let endpoint = "https://private-dbd7b7-security14.apiary-mock.com/coredata/location?type=training"

       func getLocation(_ completionHandler: @escaping (_ rooms:[JSONLocation]) -> Void) {
           
           AF.request(
                      endpoint,
                      headers: header
           ).validate().responseDecodable(of: APILocationResponse.self){
               (response) in
               guard let data = response.value else {
                   print("Error appeared")
                   print(response.error?.errorDescription! ?? "Unknown error found")
                   return
               }
               
               completionHandler(data.alllocation)
           }
           
       }
       
}
