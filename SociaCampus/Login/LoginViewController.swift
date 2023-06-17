//
//  LoginViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: mailTextField.text!,
                               password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.mailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: Segue.loginSegue, sender: nil)
                }
            }
        } else {
            self.errorMessage(titleInput: "Error", messageInput: "Enter email or password")
        }
    }
    
    @IBAction func toRegisterButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.loginSegueReg, sender: nil)
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
