//
//  TweetViewController.swift
//  Twitter
//
//  Created by Luis Rocha on 4/16/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = User.currentUser?.name
        if let screenname = User.currentUser?.screenname {
            screennameLabel.text = "@\(screenname)"
        }
        if let imageUrl = User.currentUser?.profileUrl {
            profileImageView.setImageWith(imageUrl)
        }
        messageTextView.text = ""
        messageTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onReplyButton(_ sender: Any) {
        
        TwitterClient.sharedInstance.updateStatus(message: messageTextView.text, idToReply: nil, success: {
            self.messageTextView.text = ""
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
