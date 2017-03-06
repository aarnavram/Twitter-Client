//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Aarnav Ram on 05/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweeTextView: UITextView!
    
    var userName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweeTextView.delegate = self
        print(canBecomeFirstResponder)
        if let userName = userName {
            tweeTextView.text = "@\(userName) "
        }
        tweeTextView.becomeFirstResponder()
        tweeTextView.textColor = UIColor.black
        self.automaticallyAdjustsScrollViewInsets = false
        
        
     // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCancelPressed(_ sender: Any) {
        tweeTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func onSendPressed(_ sender: Any) {
        tweeTextView.resignFirstResponder()
        TwitterClient.sharedInstance?.postTweet(status: tweeTextView.text, success: { (tweet:Tweet) in
            print(tweet.text)
        }, failure: { (error:Error) in
            print(error.localizedDescription)
        })
        //print(tweeTextView.text)
        self.dismiss(animated: true, completion: nil)
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
