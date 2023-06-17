//
//  FavoritesViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favoriteArray = [Event]()
    private var selectedIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib(nibName: "FavoritesTableView", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        if var savedEvents = UserDefaults.standard.array(forKey: "FavoriteEvents") as? [Event] {
            // Array'e eleman ekleme
            savedEvents.forEach { event in
                self.favoriteArray.append(event)
//                print(event)
                
            }
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.setupCell(event: favoriteArray[indexPath.row])
        return cell
    }
    
}
