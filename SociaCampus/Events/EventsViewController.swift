//
//  EventsViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var eventArray = [Event]()
    var favoriteTableData = [Favorite]()
    
    var eventList : [String] = []
    var searchList : [String] = []
    
    private var selectedIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "EventsTableViewCell")
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        searchBar.delegate = self
        
        getDataFromFirebase()
    }
    
    func getDataFromFirebase() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase
            .collection("Event")
            .order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in
                guard let documents = snapshot?.documents,
                      error == nil else { return }
                self.eventArray.removeAll()
                self.searchList.removeAll()
                self.eventList.removeAll()

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
                    self.eventArray.append(event)
                    self.eventList.append(eventName)
                    self.searchList.append(eventName)
                    
                }
                self.eventsTableView.reloadData()
            }
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchList.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        cell.setupCell(event: eventArray[indexPath.row])
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = searchText.isEmpty ? eventList : eventList.filter({(str : String) -> Bool in
            return str.range(of: searchText, options: .caseInsensitive) != nil
        })
        eventsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detail", sender: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let destinationVC = segue.destination as? EventDetailViewController,
            let selectedIndex {
                let detailData : Event = eventArray[selectedIndex]
                destinationVC.setupData(detailData: detailData)
            }
        }
    }
}
