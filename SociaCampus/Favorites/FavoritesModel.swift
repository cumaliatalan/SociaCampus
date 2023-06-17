//
//  FavoritesModel.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import Foundation
import UIKit

struct Favorite {
    let eventPhotoURL : String
    let eventType : String
    let eventName : String
    let eventLocation : String
    let eventDate : String
    
    init(eventPhotoURL: String, eventType: String, eventName: String, eventLocation: String, eventDate: String) {
        self.eventType = eventType
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventPhotoURL = eventPhotoURL
    }
}
