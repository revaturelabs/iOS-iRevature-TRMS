//
//  UserDefaultDAO.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation

class UserDefaultDAO {
    
    private static let defaults = UserDefaults.standard

    //save function to set userDefaults for name and address keys
    static func setUser(user: User) {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(user){
            defaults.set(encoded, forKey: "CurrentUser")
        }
    }
    
    //get details from userDefaults for userSessionKey
    static func getUser() -> User? {
        if let encodedUser = defaults.object(forKey: "CurrentUser") as? Data {
            if let user = try? PropertyListDecoder().decode(User.self, from: encodedUser) {
                return user
            }
        }
        return nil
    }
    
}
