//
//  TweetCell.swift
//  Twitter
//
//  Created by Luis Rocha on 4/16/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            retweetedLabel.isHidden = !tweet.retweeted
            retweetedImageView.isHidden = !tweet.retweeted
            if let imageUrl = tweet.user?.profileUrl {
                profileImageView.setImageWith(imageUrl)
            }
            if let name = tweet.user?.name {
                nameLabel.text = name
            }
            if let screenname = tweet.user?.screenname {
                screennameLabel.text = "@" + screenname
            }
            timestampLabel.text = tweet.timestampText
            messageLabel.text = tweet.text
            replyCountLabel.text = String("\(tweet.retweetCount)")
            retweetCountLabel.text = String("\(tweet.retweetCount)")
            favoritesCountLabel.text = String("\(tweet.favoritesCount)")
        }
    }
    
    @IBAction func onProfileImageButton(_ sender: Any) {
        var userInfo: [AnyHashable : Any] = [:]
        userInfo["user"] = tweet.user
        NotificationCenter.default.post(name: User.profileOpenNotificationName, object: self, userInfo: userInfo)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        // sync up with actual size of the label
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // sync up with actual size of the label
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
