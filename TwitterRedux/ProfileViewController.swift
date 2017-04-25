//
//  ProfileViewController.swift
//  TwitterRedux
//
//  Created by Luis Rocha on 4/20/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var user = User.currentUser
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        let cell = UINib(nibName: "TweetCell", bundle: Bundle.main)
        tableView.register(cell, forCellReuseIdentifier: "TweetCell")
        
        // initialize a UIRefreshControl
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        refreshControlAction(refreshControl)
        
        // Handle profile refresh notification.
        NotificationCenter.default.addObserver(forName: User.profileRefreshNotificationName, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            if let user = notification.userInfo?["user"] as? User {
                print("profileRefreshNotification; user=\(user.screenname!)");
                self.user = user
                self.refreshControlAction(self.refreshControl)
            }
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        MBProgressHUD.hide(for: self.view, animated: true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        print("refreshControlAction; status=start")
        
        TwitterClient.sharedInstance.getUserTweets(userId: user?.id, success: { (tweets: [Tweet]) in
            print("refreshControlAction; status=success")
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }) { (error: Error) in
            print("refreshControlAction; status=error; \(error.localizedDescription)")
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.user = user
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        
        // Pass the selected object to the new view controller.
        if let tweetDetailsViewController = navigationController.topViewController as? TweetDetailsViewController {
            // Set the model for the details view controller
            let cel = sender as! TweetCell
            tweetDetailsViewController.tweet = cel.tweet
        }
    }
}
