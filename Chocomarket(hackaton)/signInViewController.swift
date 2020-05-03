//
//  signInViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 02.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class signInViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var delivererOrNot: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        passwordText.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            errorLabel.text = error
            errorLabel.textColor = UIColor.red
        } else {
            errorLabel.text = ""
            
            let firstName = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name" : firstName, "phone": phone, "email": email, "password": password, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        // Show error message
                        self.errorLabel.text = "Error saving user data"
                    }
                }
                self.errorLabel.text = "Success"
                self.errorLabel.textColor = UIColor.green
            }
        }
    }
}
