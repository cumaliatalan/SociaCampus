//
//  ProfileViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    private let databaseRef = Database.database().reference()
    private let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var id = currentUser!.email!.replacingOccurrences(of: ".", with: "")
        
        self.databaseRef.child("user").child(id ?? "").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? NSDictionary else { return }
            let name = value["name"] as? String ?? ""
            let surname = value["surname"] as? String ?? ""
            let university = value["university"] as? String ?? ""
            let department = value["department"] as? String ?? ""
            let mail = value["mail"] as? String ?? ""
            
            self.nameLabel.text = name
            self.surnameLabel.text = surname
            self.universityLabel.text = university
            self.departmentLabel.text = department
            self.mailLabel.text = mail
        })
        

    }
    

    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: Segue.logoutSegue, sender: nil)
        } catch {
            print("Error")
        }
    }
}
