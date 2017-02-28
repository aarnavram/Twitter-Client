//
//  TweetCell.swift
//  Twitter
//
//  Created by Aarnav Ram on 24/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            if tweet.retweeted == true {
                favButton.setImage(UIImage(named: "fav-icon"), for: .normal)
            } else {
                favButton.setImage(UIImage(named: "fav-icon-red"), for: .normal)
            }
            
            if tweet.retweeted == true {
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            } else {
                self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            }
            retweetLabel.text = "\(tweet.retweetCount)"
            favLabel.text = "\(tweet.favouriteCount)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //print("this is a \(tweet)")
        retweetButton.addTarget(self, action: #selector(TweetCell.onRetweetPressed), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(TweetCell.onFavouritePressed), for: .touchUpInside)

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onRetweetPressed() {
        
        let tweetID = tweet?.id
        if tweet?.retweeted == false {
            TwitterClient.sharedInstance?.retweet(id: tweetID!, success: { (tweet: Tweet) in
                self.retweetLabel.text = "\(tweet.retweetCount)"
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }, faliure: { (error: Error) in
                print(error.localizedDescription)
            })
        } else {
            
        }
        
        print(tweet)
    }
    
    func onFavouritePressed() {
        let tweetID = tweet?.id
        if tweet.favourited == false {
            TwitterClient.sharedInstance?.favorite(id: tweetID!, success: { () in
                //self.favLabel.text = "\(tweet.favouriteCount)"
                self.favButton.setImage(UIImage(named: "fav-icon-red"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    

    
    

}
