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
            loginapi.getUserLogin(email: email, password: password, keepLoggedIn: keepLoggedIn)
            
            
            let storyboard:UIStoryboard = UIStoryboard(name: "MaintenanceCheck", bundle: nil)
            let view = storyboard.instantiateInitialViewController()!
            view.modalPresentationStyle = .fullScreen
            self.present(view, animated:true, completion: nil)
            
        } else {
            
            failMessage.text = "Invalid login details provided. Please try again"
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches , with: event)
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
            self.login()
        default:
            self.emailTextField.resignFirstResponder()
        }
    }
}

