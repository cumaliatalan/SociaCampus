//
//  DatabaseManager.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 1.06.2023.
//

import Foundation
import Firebase

class DatabaseManager {
    
    
    static let shared = DatabaseManager()
    
    private let databaseRef = Database.database().reference()
        
    public func createUser(userId: String, id: String, name: String, surname: String, university: String, department: String, mail: String, password: String) {
        self.databaseRef.child("user").child("\(id)")
            .setValue([
                "userId" : userId,
                "id" : id,
                "name" : name,
                "surname" : surname,
                "university" : university,
                "department" : department,
                "mail" : mail,
                "password" : password
            ])
    }
    
    public func addFavorite(userId: String, eventId: String) {
        self.databaseRef.child("user").child("\(userId)").child("favorite").child("\(eventId)")
            .setValue(["user" : userId])
    }
    
    public func joinToEvent(eventId: String, user: String) {
        self.databaseRef.child("event").child("\(eventId)").child("\(user)").setValue(["user" : user])
    }
        
    public func createEvent(eventType: String, eventName: String, eventLocation: String, eventDesc: String, eventTime: String) {
        let ref = databaseRef.child("event")
            .setValue([
                "eventType" : eventType,
                "eventName" : eventName,
                "eventLocation" : eventLocation,
                "eventTime" : eventTime,
                "eventDesc" : eventDesc
            ])
    }
}

