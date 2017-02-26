//
//  User.swift
//  Twitter
//
//  Created by Aarnav Ram on 22/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogout = "UserDidLogout"
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagLine: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileString = dictionary["profile_image_url_https"] as? String
        if let profileString = profileString {
            profileURL = URL(string: profileString)
        }
        tagLine = dictionary["description"] as? String
        
        
    }
    
    static var _currentUser:User?
    
    static var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "data") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "data")
                
            } else {
                defaults.set(nil, forKey: "data")

            }
            
            defaults.synchronize()
        }
    }
    
    

}
