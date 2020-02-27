//
//  ViewController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/11/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    @IBOutlet weak var keepLoggedInSwitch: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var failMessage: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    let userBusinessService = UserInfoBusinessService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Set login screen with userdetails if they exist
        if let user = UserInfoBusinessService.getUserInfo(){
            welcomeLabel.text = "Welcome back"
            userName.text = user.name
            emailTextField.text = user.email
        }
        
        //set delegate for text fields
            emailTextField.delegate = self
            passwordTextField.delegate = self
        
        //run to populate db with data
        DropAllTables.runScript()
        CreateAllTables.runScript()
        InsertDataIntoTables.runScript()
        
        LocationAPI().getLocation{(locations) in
            for location in locations{
                print(location)
            }
        }

    }
    
    
    //handle user interaction with login button
    @IBAction func userLogin(_ sender: Any) {
        self.login()
    }
    
    // login user
    func login(){
        let userEmail = emailTextField.text!
        let userPassword = passwordTextField.text!
        validateUser(email: userEmail, password: userPassword)
    }
    
    
    //validate user information
    func validateUser(email: String, password: String) {
        
        let keepLoggedIn = keepLoggedInSwitch.isOn
        
        //check if user name and password are correct
        if(email == "testuser1@revature.com" && password == "test123"){
            
            //get user information from api and set to business services
            let loginapi = LoginAPI()
            
                loginapi.getUserLogin(email: email, password: password, completionHandler:  { user in
                    let userData = User(id: 0, empID: user.emp_id, email: email, name: email, role: user.currentSystemRole.name, token: user.loginToken, keepLoggedIn: keepLoggedIn)
                    if UserInfoBusinessService.setUserInfo(userObject: userData) {
                        os_log("User defaults stored")
                    } else {
                        os_log("Unable to store user defaults")
                    }
                })
            
            //leave login and navigate to app
            navigateToMaintenanceCheck()

            
        } else {
            //provide failure message to user if login credentials are not correct
            failMessage.text = "Invalid login details provided. Please try again"
            
        }
        
    }
    
    //close keyboard if user touches outside of text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches , with: event)
    }
    
    //function to open maintenance check story boards
    func navigateToMaintenanceCheck(){
        let storyboard:UIStoryboard = UIStoryboard(name: "MaintenanceCheck", bundle: nil)
        let view = storyboard.instantiateInitialViewController()!
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated:true, completion: nil)
    }
    
}


//set up functionality to allow keyboard navigation
extension ViewController: UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchTextField(textField)
        return true
    }
    
    //check what textfield is active, switch field or close keyboard accordingly
    private func switchTextField(_ textField: UITextField){
        switch textField{
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
        default:
            self.emailTextField.resignFirstResponder()
        }
    }
}

