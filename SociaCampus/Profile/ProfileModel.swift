//
//  ProfileModel.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import Foundation

struct UserProfile {
    let name : String
    let surname : String
    let university : String
    let department : String
    let mail : String
    
    public init(name: String, surname: String, university: String, department: String, mail: String) {
        self.name = name
        self.surname = surname
        self.university = university
        self.department = department
        self.mail = mail
    }
}
