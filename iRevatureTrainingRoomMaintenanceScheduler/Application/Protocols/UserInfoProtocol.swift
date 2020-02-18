//
//  UserInfoProtocol.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/17/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation


protocol UserInfoProtocol {
    
    func getUserInfo() -> User?
    func setUserInfo(userObject: User) -> Bool
}
