//
//  MenuCell.swift
//  TwitterRedux
//
//  Created by Luis Rocha on 4/22/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!
    
    var menuText: String! {
        didSet {
            menuItemLabel.text = menuText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
