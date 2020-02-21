//
//  LoginAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/21/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class LoginAPI {
    
    let loginEndpoint: String = "https://private-dbd7b7-security14.apiary-mock.com/security/login"
    
    
    func getUserLogin(email: String, password: String, keepLoggedIn: Bool) {
        
        let login = Login(email: email, password: password)
        
        AF.request(loginEndpoint,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate()
            .responseDecodable(of: UserJSON.self)
            { (response) in
                guard let user = response.value else {
                    print("Error appeared")
                    print(response.error?.errorDescription! ?? "Unknown error found")
                    return }
                
                let userData = User(id: 0, email: email, name: email, role: user.currentSystemRole.name, token: user.loginToken, keepLoggedIn: keepLoggedIn)
                if UserInfoBusinessService.setUserInfo(userObject: userData) {
                    print("User preferences stored")
                } else {
                    print("Something went wrong")
                }
                
        }
        
    }
    
}
