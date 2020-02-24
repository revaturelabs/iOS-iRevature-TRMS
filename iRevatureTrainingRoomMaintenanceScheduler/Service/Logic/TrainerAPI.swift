//
//  TrainerAPI.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Kyle Keck on 2/22/20.
//  Copyright © 2020 revature. All rights reserved.
//

import Foundation
import Alamofire

class TrainerAPI:API {
    
    let trainerEndpoint = "https://private-dbd7b7-security14.apiary-mock.com/coredata/trainers"

    func getTrainers(_ completionHandler: @escaping (_ trainers:[JSONTrainer]) -> Void) {
        
        AF.request(
                   trainerEndpoint,
                   headers: header
        ).validate().responseDecodable(of: APITrainerResponse.self){
            (response) in
            guard let data = response.value else {
                print("Error appeared")
                print(response.error?.errorDescription! ?? "Unknown error found")
                return
            }
            
            completionHandler(data.trainers)
        }
        
    }
    
}
