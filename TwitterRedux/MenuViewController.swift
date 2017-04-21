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
    
    let menuOptions = [ "Profile", "Timeline", "Mentions" ]
    
    private var profileViewController: UIViewController!
    private var timelineViewController: UIViewController!
    private var mentionsViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        timelineViewController = storyboard.instantiateViewController(withIdentifier: "TimelineViewController")
        mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController")
        viewControllers.append(profileViewController)
        viewControllers.append(timelineViewController)
        viewControllers.append(mentionsViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = menuOptions[indexPath.row]
        return cell
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
