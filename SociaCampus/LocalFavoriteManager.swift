//
//  LocalFavoriteManager.swift
//  SociaCampus
//
//  Created by Halit Baskurt on 17.06.2023.
//

import Foundation

@propertyWrapper struct AppStorage {
    private let key: String
    private let defaultValue: [String]
    
    init(key: String, defaultValue: [String]) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: [String] {
        get {
            if let data = UserDefaults.standard.array(forKey: key) as? [String] {
            return data
            } else {
                return defaultValue
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}


final class LFManager {
    static var shared: LFManager = .init()
    @AppStorage(key: "favoriteItems", defaultValue: []) private(set) var favoriteItems: [String] {
        didSet { favoriteItemsChanged?() }
    }
    
    var favoriteItemsChanged: (() -> Void)?
    var didRemovedFavoriteItem: ((String) -> Void)?
    
    func checkIsFavorite(favoriteID: String) -> Bool { favoriteItems.contains(favoriteID) }
    
    func removeFromFavorite(favoriteID: String) {
        if let indexOfFavoriteItem = favoriteItems.firstIndex(where: {$0 == favoriteID}) {
            favoriteItems.remove(at: indexOfFavoriteItem)
            didRemovedFavoriteItem?(favoriteID)
        }
    }
    
    func addToFavorite(for favoriteID: String) {
        favoriteItems.append(favoriteID)
    }
}
