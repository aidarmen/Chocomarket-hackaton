//
//  signInViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 02.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit

class signInViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
