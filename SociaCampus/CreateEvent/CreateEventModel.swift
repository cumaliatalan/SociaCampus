//
//  CreateEventModel.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import Foundation
import UIKit

struct CreateEvent {
    let eventPhotoURL : String
    let eventType : String
    let eventName : String
    let eventLocation : String
    let eventDate : Date
    let eventDesc : String
    
    init(eventPhotoURL: String, eventType: String, eventName: String, eventLocation: String, eventDate: Date, eventDesc: String) {
        self.eventType = eventType
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventDesc = eventDesc
        self.eventPhotoURL = eventPhotoURL
    }
}
