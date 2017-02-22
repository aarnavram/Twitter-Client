//
//  User.swift
//  Twitter
//
//  Created by Aarnav Ram on 22/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagLine: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileString = dictionary["profile_image_url_https"] as? String
        if let profileString = profileString {
            profileURL = URL(string: profileString)
        }
        tagLine = dictionary["description"] as? String
        
        
    }

}
