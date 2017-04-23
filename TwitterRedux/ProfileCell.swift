//
//  ProfileCell.swift
//  TwitterRedux
//
//  Created by Luis Rocha on 4/22/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!

    var user: User! {
        didSet {
            if let imageUrl = user?.profileBannerUrl {
                bannerImageView.setImageWith(imageUrl)
            }
            if let imageUrl = user?.profileUrl {
                profileImageView.setImageWith(imageUrl)
            }
            if let name = user?.name {
                nameLabel.text = name
            }
            if let screenname = user?.screenname {
                screennameLabel.text = "@" + screenname
            }
            if let location = user?.location {
                locationLabel.text = location
            }
            tweetsCountLabel.text = String("\(user.statusesCount)")
            followingCountLabel.text = String("\(user.friendsCount)")
            followersCountLabel.text = String("\(user.followersCount)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        // sync up with actual size of the label
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
