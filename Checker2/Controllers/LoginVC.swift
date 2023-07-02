//
//  LoginVC.swift
//  Checker2
//
//  Created by bmtech on 01.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class LoginVC: UIViewController {
    var signUp: Bool = false {
        willSet {
            if newValue {
                nameLabel.isHidden = false
                nameField.isHidden = false
                confirmPasswordLabel.isHidden = false
                confirmPasswordField.isHidden = false
                facebookButton.isHidden = true
                googleButton.isHidden = true
                forgotPasswordLabel.isHidden = true
                continueLogin.isHidden = true
                dontLoginLabel.isHidden = true
                signUpButton.isHidden = true
                loginButton.setTitle("Registration", for: .normal)
            } else {
                nameLabel.isHidden = true
                nameField.isHidden = true
                confirmPasswordLabel.isHidden = true
                confirmPasswordField.isHidden = true
                facebookButton.isHidden = false
                googleButton.isHidden = false
                continueLogin.isHidden = false
                dontLoginLabel.isHidden = false
                signUpButton.isHidden = false
                loginButton.setTitle("Login", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var continueLogin: UILabel!
    @IBOutlet weak var dontLoginLabel: UILabel!
    @IBOutlet weak var forgotPasswordLabel: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupStarting()
        setupFields()
        correct()
    }
    // setup settings view
    func setupVC() {
        navigationItem.hidesBackButton = true
        navigationItem.title = ""
        view.backgroundColor = Colors.myColorBlack
        nameLabel.textColor = Colors.myColorGray
        emailLabel.textColor = Colors.myColorGray
        passwordLabel.textColor = Colors.myColorGray
        confirmPasswordLabel.textColor = Colors.myColorGray
        continueLogin.textColor = Colors.myColorGray
        dontLoginLabel.textColor = Colors.myColorGray
    }
    //setup settings for starting screen
    func setupStarting() {
        nameLabel.isHidden = true
        nameField.isHidden = true
        confirmPasswordLabel.isHidden = true
        confirmPasswordField.isHidden = true
        loginButton.setTitle("Login", for: .normal)
    }
    //delegates text fields
    func setupFields() {
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    //func for correct a work on simulator
    func correct() {
        emailField.textContentType = UITextContentType(rawValue: "")
        passwordField.textContentType = UITextContentType(rawValue: "")
    }
    //segue to stocks VC
    func goToVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StockNew2VC")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func loginOnClick(_ sender: Any) {
        if loginButton.titleLabel?.text == "Registration"{
            signUp = !signUp
        } else {
             Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
                if error == nil {
                    self.goToVC()
                } else {
                    //error description
                    print("some sign in error, plese correct!")
                    self.showAlert()
                }
            }
        }
        
    }

    
    
    @IBAction func facebookOnClick(_ sender: Any) {
        do {
            print("deleted")
        } catch {
            print("no delete")
        }
    }
    
    @IBAction func googleOnClick(_ sender: Any) {
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUp = !signUp
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Please fill all fields!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func showAlertPassword() {
        let alert = UIAlertController(title: "Error", message: "Please correct email or password!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func showAllOk() {
        let alert = UIAlertController(title: "Success", message: "Email and password is correct!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let email = emailField.text!
        let name = nameField.text!
        let password = passwordField.text!
        
        if (signUp) {
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result{
                            print(result.user.uid)
                            let db = Firestore.firestore()
                            db.collection("users").addDocument(data: [
                                "name": self.nameField.text!,
                                "uid": result.user.uid
                            ])
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name": name, "email": email])
                            self.dismiss(animated: true)
                        }
                    }
                }
            } else {
                showAlert()
            }
        } else {
            if(!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                    if error == nil {
                        self.dismiss(animated: true)
                        print("All ok")
                    }
                })
            } else {
                showAlert()
            }
        }
        return true
    }
}

