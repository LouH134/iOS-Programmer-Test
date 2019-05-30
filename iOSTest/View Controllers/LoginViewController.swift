//
//  LoginViewController.swift
//  iOSTest
//
//  Created by D & A Technologies on 1/22/18.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take username and password input from the user using UITextFields
     *
     * 3) Using the following endpoint, make a request to login
     *    URL: http://dev.datechnologies.co/Tests/scripts/login.php
     *    Parameter One: email
     *    Parameter Two: password
     *
                            info@datechnologies.co
     * 4) A valid email is 'info@datechnologies.co'
     *    A valid password is 'Test123'
     *
     * 5) Calculate how long the API call took in milliseconds
     *
     * 6) If the response is an error display the error in a UIAlertView
     *
     * 7) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertView
     *
     * 8) When login is successful, tapping 'OK' in the UIAlertView should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    @IBOutlet var usernameTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        configureTxtFields()
        configureTxtPadding()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTxtFields(){
        usernameTxtField.layer.cornerRadius = 5.0
        usernameTxtField.layer.borderWidth = 0.5
        passwordTxtField.layer.cornerRadius = 5.0
        passwordTxtField.layer.borderWidth = 0.5
    }
    
    func configureTxtPadding(){
        usernameTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: usernameTxtField.frame.height))
        usernameTxtField.leftViewMode = .always
        
        passwordTxtField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: passwordTxtField.frame.height))
        passwordTxtField.leftViewMode = .always
    }
    
    func checkForText(){
        let textAlertController = UIAlertController(title: "Empty Textfield!", message: "Please enter both a username and password. ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default){(UIAlertAction) in
            print("You Pressed button")
        }
        
        textAlertController.addAction(action)
        
        self.present(textAlertController, animated: true, completion: nil)
    }
    
    func login(){
        let loginRequest = LoginClient()
        loginRequest.login(withUsername: usernameTxtField.text, password: passwordTxtField.text, completion: { [weak self] (json, error) in
            DispatchQueue.main.async {
                
                guard let self = self else { return }
                if let error = error {
                    let errorAlertController = UIAlertController(title: "Login Error!", message: error.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default){(UIAlertAction) in
                        print("You Pressed button")
                    }
                    
                    errorAlertController.addAction(action)
                    
                    self.present(errorAlertController, animated: true, completion: nil)
                } else {
                    let requestDurationInSeconds = json?["requestDuration"] as? Double ?? 0.0 
                    let requestDurationInMiliseconds : Int = Int(requestDurationInSeconds * 1000)
                    
                    let successAlertControler = UIAlertController(title: "Login Success!", message: "The request took \(requestDurationInMiliseconds) ms.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default){(UIAlertAction) in
                        print("You Pressed button")
                        
                    
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                    successAlertControler.addAction(action)
                    
                    self.present(successAlertControler, animated: true, completion: nil)
                }
            }
        })
    }
    // MARK: - Actions
    @IBAction func didPressLoginButton(_ sender: Any) {
        if usernameTxtField.hasText && passwordTxtField.hasText{
            login()
        }else{
            checkForText()
        }
    }
}
