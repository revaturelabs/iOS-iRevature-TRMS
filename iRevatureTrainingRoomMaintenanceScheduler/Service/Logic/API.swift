//
//  API.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/22/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    let user = UserInfoBusinessService.getUserInfo()
    var token:String = ""
    var header:HTTPHeaders = []

    
    init(){
        if let token = user?.token {
            self.token = token
            self.header = [
                "Authorization": "Bearer \(token))"
            ]
        }
    }
    
}
