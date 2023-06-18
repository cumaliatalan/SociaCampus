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
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var event : Event?
    let user = Auth.auth().currentUser?.email
    private var eventId: String = ""
    
    private var isFavorite: Bool?
    
    func setupCell(event : Event) {
        self.event = event
        eventName.text = event.eventName
        eventType.text = event.eventType
        eventImage.sd_setImage(with: URL(string: event.eventPhotoURL))
        eventLocation.text = event.eventLocation
        eventDate.text = event.eventDate
        eventId = event.eventId
        
        self.isFavorite = LFManager.shared.checkIsFavorite(favoriteID: event.eventId)
        updateFavoriteIcon(isFavorite: self.isFavorite)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        var userString = self.user?.replacingOccurrences(of: ".", with: "")
        DatabaseManager.shared.joinToEvent(eventId: self.eventId, user: userString ?? "")
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        guard let event, let isFavorite = self.isFavorite  else { return }
        if isFavorite {
            LFManager.shared.removeFromFavorite(favoriteID: event.eventId)
        } else {
            LFManager.shared.addToFavorite(for: event.eventId)
        }
        self.isFavorite?.toggle()
        updateFavoriteIcon(isFavorite: self.isFavorite)
    }
    
    private func updateFavoriteIcon(isFavorite: Bool?) {
        guard let isFavorite = self.isFavorite else { return }
        DispatchQueue.main.async {
            self.favoriteButton.imageView?.image = isFavorite ?
            UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
        
    }
}
