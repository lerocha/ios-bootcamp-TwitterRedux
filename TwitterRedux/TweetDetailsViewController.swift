//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Luis Rocha on 4/16/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

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
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var replyLabel: UILabel!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        messageTextView.text = ""
        messageTextView.becomeFirstResponder()
        if let tweet = tweet {
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
                replyLabel.text = "Replying to @\(screenname)"
            }
            timestampLabel.text = tweet.timestampText
            messageLabel.text = tweet.text
            replyCountLabel.text = String("\(tweet.retweetCount)")
            retweetCountLabel.text = String("\(tweet.retweetCount)")
            favoritesCountLabel.text = String("\(tweet.favoritesCount)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onReplyButton(_ sender: Any) {
        TwitterClient.sharedInstance.updateStatus(message: messageTextView.text, idToReply: tweet?.id, success: {
            self.messageTextView.text = ""
            self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterClient.sharedInstance.retweet(id: tweet!.id, success: {
            self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        TwitterClient.sharedInstance.createFavorite(id: tweet!.id, success: {
            self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
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
