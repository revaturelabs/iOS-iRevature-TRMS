//
//  ViewController.swift
//  iRevatureTrainingRoomMaintenanceScheduler
//
//  Created by Mark Hawkins on 2/11/20.
//  Copyright © 2020 revature. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var keepLoggedInSwitch: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var failMessage: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    let userBusinessService = UserInfoBusinessService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = UserInfoBusinessService.getUserInfo(){
            welcomeLabel.text = "Welcome back"
            emailTextField.text = user.email
            
            emailTextField.delegate = self
            passwordTextField.delegate = self
        }

        DropAllTables.runScript()
        CreateAllTables.runScript()
        InsertDataIntoTables.runScript()
        
//        CreateAllTables.runScript()
        
//        let filePath = DatabaseAccess.getDatabaseFilePath(name: DatabaseInfo.databaseName, pathDirectory: DatabaseInfo.databaseDirectory, domainMask: DatabaseInfo.databaseDomainMask)
//
//        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
//
//        print(LocationTable.getAllValues(database: db!)!)

        
    }
    
    
    @IBAction func userLogin(_ sender: Any) {
        self.login()
    }
    
    
    func login(){
        let userEmail = emailTextField.text!
        let userPassword = passwordTextField.text!
        validateUser(email: userEmail, password: userPassword)
    }
    
    
    
    func validateUser(email: String, password: String) {
        
        let keepLoggedIn = keepLoggedInSwitch.isOn
        
        if(email == "testuser1@revature.com" && password == "test123"){
            
            let loginapi = LoginAPI()
            
            loginapi.getUserLogin(email: email, password: password, completionHandler:  { user in
                let userData = User(id: 0, email: email, name: email, role: user.currentSystemRole.name, token: user.loginToken, keepLoggedIn: keepLoggedIn)
                if UserInfoBusinessService.setUserInfo(userObject: userData) {
                    print("User preferences stored")
                } else {
                    print("Something went wrong")
                }
            })
            
            navigateToMaintenanceCheck()
            
        } else {
            
            failMessage.text = "Invalid login details provided. Please try again"
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches , with: event)
    }
    
    
    func navigateToMaintenanceCheck(){
        let storyboard:UIStoryboard = UIStoryboard(name: "MaintenanceCheck", bundle: nil)
        let view = storyboard.instantiateInitialViewController()!
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated:true, completion: nil)
    }
    
}


extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchTextField(textField)
        return true
    }
    
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

