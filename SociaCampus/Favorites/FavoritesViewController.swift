//
//  FavoritesViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import FirebaseFirestore
class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let favoriteManager: LFManager = .shared
    private var eventArray = [Event]()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var selectedIndex : Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromFirebase()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil),
                                    forCellReuseIdentifier: "EventsTableViewCell")
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        addObserverToFavoritesList()
        
        
    }
    
    //FIXME: Bunu da networkManager gibi bişi yap her ihtiyacın oldu mu ordan çekersin duplice olmaz.
    func getDataFromFirebase() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase
            .collection("Event")
            .order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in
                guard let documents = snapshot?.documents,
                      error == nil else { return }
                self.eventArray.removeAll()
                documents.forEach { document in
                    var sharedDocumentID = document.documentID
                    print("\(document.documentID)") //MARK: BUNUN AKTARILMASI LAZIM!!
                    let data = document.data()
                    let eventPhotoURL = data["eventPhotoURL"] as? String ?? ""
                    let eventType = data["eventType"] as? String ?? ""
                    let eventName = data["eventName"] as? String ?? ""
                    let eventLocation = data["eventLocation"] as? String ?? ""
                    let eventDesc = data["eventDesc"] as? String ?? ""
                    let eventDate = data["eventDate"] as? String ?? ""
                    let event = Event(eventPhotoURL: eventPhotoURL, eventType: eventType, eventName: eventName,
                                      eventLocation: eventLocation, eventDesc: eventDesc, eventDate: eventDate, eventId: sharedDocumentID)

                    if LFManager.shared.checkIsFavorite(favoriteID: sharedDocumentID) { self.eventArray.append(event) }

                }
                self.favoritesTableView.reloadData()
            }
    }
    
    private func addObserverToFavoritesList() {
        LFManager.shared.favoriteItemsChanged = { }
        
        LFManager.shared.didRemovedFavoriteItem = { removedItem in
            if let indexOfRemovedItem = self.eventArray.firstIndex(where: { $0.eventId == removedItem }) {
                self.eventArray.remove(at: indexOfRemovedItem)
                self.favoritesTableView.reloadData()
            }
            
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 112 }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        cell.setupCell(event: eventArray[indexPath.row])
        return cell
    }
    
    //TODO: Segueni flan bağlarsın.
    
}
