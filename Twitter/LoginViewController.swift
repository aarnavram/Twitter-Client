//
//  LoginViewController.swift
//  Twitter
//
//  Created by Aarnav Ram on 21/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginPressed(_ sender: AnyObject) {
    
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "19o1QKYaIxn8V3B8ghjq51W1i", consumerSecret: "cFiQ2MxMbKckJNo4qvrLfRR9nIP45iIIwcP1hUrkLLrFBCaWhp")
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "myTwitterApp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
            let token = requestToken?.token
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)")
            
            UIApplication.shared.open(url!, options: [:], completionHandler: { (result : Bool) in
                print(result)
            })
            
            }, failure: { (error: Error?) in
                print(error?.localizedDescription)
        })
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
