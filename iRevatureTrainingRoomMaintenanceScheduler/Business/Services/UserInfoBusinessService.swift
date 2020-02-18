//
//  UserInfoBusinessService.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class UserInfoBusinessService: UserInfoProtocol {
    
    
    
    func getUserInfo() -> User? {
        let defaults = UserDefaults.standard
        
        if let decodedUserInfo = (defaults.value(forKey: "UserSharedInfo")){
         
            let decodedUser = try? PropertyListDecoder().decode(User.self, from: decodedUserInfo as! Data)
            
            return decodedUser
            
        } else {
            
            return nil
        }
        
    }
    
    func setUserInfo(userObject: User) -> Bool {
        let defaults = UserDefaults.standard
        
        do{
            
            try defaults.set(PropertyListEncoder().encode(userObject), forKey: "UserSharedInfo")
            
            return true
            
        } catch {
            return false
        }
    }

}
