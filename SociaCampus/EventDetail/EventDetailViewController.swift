//
//  EventDetailViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import SDWebImage

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDesc: UITextView!
    
    private (set) var detailData : Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailData = self.detailData else { return }
        eventType.text = detailData.eventType
        eventName.text = detailData.eventName
        eventLocation.text = "\(detailData.eventLocation) /"
        eventDesc.text = detailData.eventDesc
        eventDate.text = detailData.eventDate
        eventImageView.sd_setImage(with: URL(string: detailData.eventPhotoURL))
        
    }
    
    func setupData(detailData: Event) {
        self.detailData = detailData
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toTabbarfromDetail", sender: nil)
    }
    
}
