//
//  AppDelegate.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/11/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UITabBar.appearance().barTintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
//        UITabBar.appearance().tintColor = .black
        
        let userInfoService = UserInfoBusinessService()
        
        let user: User? = userInfoService.getUserInfo()
        
        if user == nil || !user!.keepLoggedIn {
            
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateInitialViewController()!
            self.window?.rootViewController = view
            
        } else {
            
            let storyboard:UIStoryboard = UIStoryboard(name: "MaintenanceCheck", bundle: nil)
            let view = storyboard.instantiateInitialViewController()!
            self.window?.rootViewController = view
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

