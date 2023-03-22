//
//  LoginVC.swift
//  Checker2
//
//  Created by bmtech on 01.08.2022.
//

import UIKit

class LoginVC: UIViewController {
    
    var myColorBlack = UIColor(hex: 0x16171C)
    var myColorGray = UIColor(hex: 0x312E49)
    var myColorBlueLabel = UIColor(hex: 0x487FD9)

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var continueLogin: UILabel!
    @IBOutlet weak var dontLoginLabel: UILabel!
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = ""
        view.backgroundColor = myColorBlack
        emailLabel.textColor = myColorGray
        passwordLabel.textColor = myColorGray
        continueLogin.textColor = myColorGray
        dontLoginLabel.textColor = myColorGray

    }

    @IBAction func loginOnClick(_ sender: Any) {
    }
    
    @IBAction func facebookOnClick(_ sender: Any) {
    }
    
    @IBAction func googleOnClick(_ sender: Any) {
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
}
