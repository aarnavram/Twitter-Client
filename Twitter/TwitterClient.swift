//
//  TwitterClient.swift
//  Twitter
//
//  Created by Aarnav Ram on 22/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "19o1QKYaIxn8V3B8ghjq51W1i", consumerSecret: "cFiQ2MxMbKckJNo4qvrLfRR9nIP45iIIwcP1hUrkLLrFBCaWhp")
    
    var loginSucess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {

        TwitterClient.sharedInstance?.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let responseDictionaries = response as! [NSDictionary]
            let tweets = Tweet.TweetsFromArray(dictionaries: responseDictionaries)
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func verifyCredentials() {
        TwitterClient.sharedInstance?.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response : Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            print(user.name!)
            }, failure: { (task: URLSessionDataTask?, error:Error) in
                error.localizedDescription
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSucess = success
        loginFailure = failure
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "myTwitterApp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
            let token = requestToken?.token
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)")
            
            UIApplication.shared.open(url!, options: [:], completionHandler: { (result : Bool) in
                print(result)
            })
            
            }, failure: { (error: Error?) in
                print(error?.localizedDescription)
                self.loginFailure?(error!)
        })

    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            self.loginSucess?()
            
            }, failure: { (error: Error?) in
                print(error?.localizedDescription)
                self.loginFailure?(error!)
        })
    }
    
}
