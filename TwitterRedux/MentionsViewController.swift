//
//  MentionsViewController.swift
//  TwitterRedux
//
//  Created by Luis Rocha on 4/20/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit
import MBProgressHUD

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        refreshControlAction(refreshControl)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        TwitterClient.sharedInstance.getMentions(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }) { (error: Error) in
            print(error.localizedDescription)
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.item]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetDetailsViewController = storyboard.instantiateViewController(withIdentifier: "TweetDetailsViewController") as! TweetDetailsViewController
        // Set the model for the details view controller
        tweetDetailsViewController.tweet = tweets[indexPath.item]
        self.navigationController?.pushViewController(tweetDetailsViewController, animated: true)
    }
}
