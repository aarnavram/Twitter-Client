//
//  Tweet.swift
//  Twitter
//
//  Created by Aarnav Ram on 22/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var timestamp: NSDate?
    var user: String?
    var retweetCount: Int = 0
    var favouriteCount: Int = 0
    var text: String?
    var imageURL: String?
    var id:String?
    var retweeted:Bool!
    var favourited:Bool!
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        let userDictionary = dictionary["user"] as! NSDictionary
        imageURL = userDictionary["profile_image_url_https"] as? String
        user = userDictionary["name"] as? String
        id = dictionary["id_str"] as? String
        retweeted = dictionary["retweeted"] as! Bool
        favourited = dictionary["retweeted"] as! Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouriteCount = (userDictionary["favorite_count"] as? Int) ?? 0
//        favouriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString) as NSDate?
        }
        
        
    }
    
    class func TweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }
    

}
