//
//  User.swift
//  Twitter
//
//  Created by Luis Rocha on 4/15/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class User: NSObject {
    static let logoutNotificationName = Notification.Name(rawValue: "UserLogout")
    static let loginNotificationName = Notification.Name(rawValue: "UserLogin")

    var id: Int64 = 0
    var name: String?
    var screenname: String?
    var tagline: String?
    var followersCount: Int = 0
    var friendsCount: Int = 0
    var listedCount: Int = 0
    var favoritesCount: Int = 0
    var following: Bool = false
    var dateCreated: Date?
    var profileUrl: URL?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = (dictionary["id"] as? Int64) ?? 0
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        friendsCount = (dictionary["friends_count"] as? Int) ?? 0
        listedCount = (dictionary["listed_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        following = (dictionary["following"] as? Bool) ?? false
        let dateCreatedString = dictionary["created_at"] as? String
        
        if let dateCreatedString = dateCreatedString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            dateCreated = formatter.date(from: dateCreatedString)
        }
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
    }

    
    static var _currentUser: User?
    static var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let data = defaults.object(forKey: "currentUserData") as? Data
                if let data = data {
                    if let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        _currentUser = User(dictionary: dictionary)
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
