//
//  SignUpVC.swift
//  Checker2
//
//  Created by bmtech on 05.08.2022.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.myColorBlack
        emailTextField.textColor = Colors.myColorGray
        passwordTextField.textColor = Colors.myColorGray
        confirmPasswordTextField.textColor = Colors.myColorGray
        
    }
    @IBAction func signUpButton(_ sender: Any) {
        if let login = emailTextField.text, let password = passwordTextField.text {
            do {

            } catch {
                print("Unable to save data")
            }
        }
    }
    
    
}
