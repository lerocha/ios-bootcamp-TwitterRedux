//
//  Tweet.swift
//  Twitter
//
//  Created by Luis Rocha on 4/15/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class Tweet: NSObject {
 
    var id: Int64 = 0
    var text: String?
    var timestamp: Date?
    var timestampText: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var truncated: Bool = false
    var retweeted: Bool = false
    var favorited: Bool = false
    var retweetedStatus: Tweet?
    var user: User?

    init(dictionary: NSDictionary) {
        id = (dictionary["id"] as? Int64) ?? 0
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        truncated = (dictionary["truncated"] as? Bool) ?? false
        retweeted = (dictionary["retweeted"] as? Bool) ?? false
        favorited = (dictionary["favorited"] as? Bool) ?? false
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
            timestampText = Tweet.getTimestampText(date: timestamp!)
        }
        
        if let retweetStatusDictionary = dictionary["retweeted_status"] as? NSDictionary {
            retweetedStatus = Tweet(dictionary: retweetStatusDictionary)
        }
        
        if let userDictionary = dictionary["user"] as? NSDictionary {
            user = User(dictionary: userDictionary)
        }
    }
    
    static func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    static func getTimestampText(date: Date) -> String {
        let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
        if days > 30 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yy"
            return dateFormatter.string(from: date)
        }
        if days > 0 {
            return String("\(days)d")
        }
        
        let hours = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
        if hours > 0 {
            return String("\(hours)h")
        }
        
        let minutes = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
        return String("\(minutes)m")
    }
}
