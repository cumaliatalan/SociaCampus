//
//  FavoritesTableViewCell.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 9.06.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventType: UILabel!
    
    let user = Auth.auth().currentUser!.email
    var eventId : String = ""
    
    func setupCell(event : Event) {
        eventName.text = event.eventName
        eventType.text = event.eventType
        eventImage.sd_setImage(with: URL(string: event.eventPhotoURL))
        eventLocation.text = event.eventLocation
        eventId = event.eventId
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        DatabaseManager.shared.joinToEvent(eventId: self.eventId, user: user ?? "")
        
    }
    
}
