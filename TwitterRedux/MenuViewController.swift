//
//  MenuViewController.swift
//  TwitterRedux
//
//  Created by Luis Rocha on 4/20/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let menuOptions = [ "Profile", "Timeline", "Mentions", "Log Out" ]
    
    private var profileViewController: UIViewController!
    private var timelineViewController: UIViewController!
    private var mentionsViewController: UIViewController!
    private var loginViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var hamburguerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        timelineViewController = storyboard.instantiateViewController(withIdentifier: "TimelineViewController")
        mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController")
        loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        viewControllers.append(profileViewController)
        viewControllers.append(timelineViewController)
        viewControllers.append(mentionsViewController)
        viewControllers.append(loginViewController)

        // Handle login notification to change content view to timeline.
        NotificationCenter.default.addObserver(forName: User.loginNotificationName, object: nil, queue: OperationQueue.main) { (notification) in
            print("loginNotificationName")
            self.hamburguerViewController.contentViewController = self.timelineViewController
        }
        
        // Handle profile view notification.
        NotificationCenter.default.addObserver(forName: User.profileOpenNotificationName, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            if let user = notification.userInfo?["user"] as? User {
                print("profileOpenNotification; user=\(user.screenname!)");
                self.hamburguerViewController.contentViewController = self.profileViewController
                NotificationCenter.default.post(name: User.profileRefreshNotificationName, object: nil, userInfo: notification.userInfo)
            }
        }
        
        // Sets initial content view depending
        if User.currentUser == nil {
            hamburguerViewController.contentViewController = loginViewController
        } else {
            hamburguerViewController.contentViewController = timelineViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuText = menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contentViewController = viewControllers[indexPath.row]
        if contentViewController == loginViewController {
            TwitterClient.sharedInstance.logout()
        }
        if contentViewController == profileViewController {
            var userInfo: [AnyHashable : Any] = [:]
            userInfo["user"] = User.currentUser
            NotificationCenter.default.post(name: User.profileRefreshNotificationName, object: nil, userInfo: userInfo)
        }
        hamburguerViewController.contentViewController = viewControllers[indexPath.row]
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
