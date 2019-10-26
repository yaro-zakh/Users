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
    
    var user: User? {
        didSet {
            userNameLabel.text = user?.firstName
            lastNameLabel.text = user?.lastName
            userPhoto.load(url: user?.avatar)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
