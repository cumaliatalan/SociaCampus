//
//  EventsTableViewCell.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 7.06.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth
import NotificationCenter

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    private var event : Event?
    let user = Auth.auth().currentUser?.email
    private var eventId: String = ""
    func setupCell(event : Event) {
        self.event = event
        eventName.text = event.eventName
        eventType.text = event.eventType
        eventImage.sd_setImage(with: URL(string: event.eventPhotoURL))
        eventLocation.text = event.eventLocation
        eventDate.text = event.eventDate
        eventId = event.eventId
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        var userString = self.user?.replacingOccurrences(of: ".", with: "")
        DatabaseManager.shared.joinToEvent(eventId: self.eventId, user: userString ?? "")
        
    }
    

    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        
        // image degisimini halledem
        /*
        if let eventData = try? JSONEncoder().encode(event),
           let eventJSON = String(data: eventData, encoding: .utf8) {
            // JSON'u UserDefaults'a kaydetme
            UserDefaults.standard.set(eventJSON, forKey: "FavoriteEvents")
        }
        
        if var savedEvents = UserDefaults.standard.array(forKey: "FavoriteEvents") as? [Event],
           let event = event {
            if let eventData = try? JSONEncoder().encode(event),
               let eventJSON = String(data: eventData, encoding: .utf8) {
                
                UserDefaults.standard.set(eventJSON, forKey: "FavoriteEvents")
                print("event: \(eventJSON)")
            }
            
            

        }
        
        if var savedEvents = UserDefaults.standard.array(forKey: "FavoriteEvents") as? [Event] {
            print("savedEvents: \(savedEvents)")
        }
        */
        
    }

}
