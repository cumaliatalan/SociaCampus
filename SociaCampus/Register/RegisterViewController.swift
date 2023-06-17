//
//  RegisterViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonAction(_ sender: Any) {
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let email = mailTextField.text,
              let university = universityTextField.text,
              let department = departmentTextField.text,
              let password = passwordTextField.text else { return }
        let uuid = UUID().uuidString
        var id = email.replacingOccurrences(of: ".", with: "")
        if name != "" && surname != "" && email != "" && password != "" && university != "" && department != "" {
            let user = User(userId: uuid, id: id, name: name, surname: surname,
                            university: university, department: department, email: email, password: password)
            
            DatabaseManager.shared.createUser(userId: uuid, id: user.id, name: user.name,
                                              surname: user.surname,  university: user.university,
                                              department: user.department, mail: user.email, password: user.password)
            
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, authError in
                if let error = authError {
                    self.errorMessage(titleInput: "Error", messageInput: "\(error)")
                } else {
                    
                    self.nameTextField.text = ""
                    self.surnameTextField.text = ""
                    self.universityTextField.text = ""
                    self.departmentTextField.text = ""
                    self.mailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: Segue.registerSegue, sender: nil)
                }
            }
        } else {
            self.errorMessage(titleInput: "Error", messageInput: "Tüm boşlukları doldurunuz!")
        }
    }
    
    @IBAction func toLogInButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.registerSegueLog, sender: nil)
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
