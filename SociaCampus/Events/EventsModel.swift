//
//  EventsModel.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import Foundation
import UIKit

struct Event {
    let eventPhotoURL : String
    let eventType : String
    let eventName : String
    let eventLocation : String
    let eventDesc : String
    let eventDate : String
    // let isFavorite : Bool
    let eventId : String //: documentId alacak
    
    init(eventPhotoURL: String, eventType: String, eventName: String, eventLocation: String, eventDesc : String, eventDate : String, eventId: String) {
        self.eventType = eventType
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventPhotoURL = eventPhotoURL
        self.eventDesc = eventDesc
        self.eventId = eventId
    }
}
