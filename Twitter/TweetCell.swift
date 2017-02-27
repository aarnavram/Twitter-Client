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
    override func awakeFromNib() {
        super.awakeFromNib()
        retweetButton.addTarget(self, action: #selector(TweetCell.onRetweetPressed), for: .touchUpInside)


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onRetweetPressed() {
        retweetButton.imageView?.image = UIImage(named: "retweet-icon-green.png")
    }
    
    func onFavouritePressed() {
        favButton.imageView?.image = UIImage(named: "favor-icon-red")
    }

}
