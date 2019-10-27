//
//  UserInfoTableViewCell.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var avatarActivityIndicator: UIActivityIndicatorView!
    
    var user: User? {
        didSet {
            avatarActivityIndicator.startAnimating()
            userNameLabel.text = user?.firstName
            lastNameLabel.text = user?.lastName
            userPhoto.load(url: user?.avatar) {
                self.avatarActivityIndicator.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.userPhoto.layer.cornerRadius = self.userPhoto.frame.height/2
        self.userPhoto.clipsToBounds = true
    }
}
