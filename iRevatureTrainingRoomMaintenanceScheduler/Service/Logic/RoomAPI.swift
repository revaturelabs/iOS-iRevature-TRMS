//
//  RoomAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/22/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class RoomAPI: API {
    
       let roomEndpoint = "https://private-dbd7b7-security14.apiary-mock.com/coredata/room?type=training"

       func getRooms(_ completionHandler: @escaping (_ rooms:[JSONRoom]) -> Void) {
           
           AF.request(
                      roomEndpoint,
                      headers: header
           ).validate().responseDecodable(of: APIRoomResponse.self){
               (response) in
               guard let data = response.value else {
                   print("Error appeared")
                   print(response.error?.errorDescription! ?? "Unknown error found")
                   return
               }
               
               completionHandler(data.allrooms)
           }
           
       }
       
}
