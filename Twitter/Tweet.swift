//
//  Tweet.swift
//  Twitter
//
//  Created by Aarnav Ram on 22/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favouriteCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString) as NSDate?
        }
        
        
    }
    
//    class func TweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
//        var tweets = [Tweet]()
//        
//        for dictionary in dictionaries {
//            let tweet = Tweet(dictionary: dictionary)
//        }
//        
//    }
//    

}
