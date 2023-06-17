//
//  RegisterLogin.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import Foundation

class User {
    
    var userId: String
    var id: String
    var name: String
    var surname: String
    var university: String
    var department: String
    var email: String
    var password: String
    
    init(userId: String, id: String, name: String, surname: String,
         university: String, department: String, email: String, password: String) {
        self.userId = userId
        self.id = id
        self.name = name
        self.surname = surname
        self.university = university
        self.department = department
        self.email = email
        self.password = password
    }
}
