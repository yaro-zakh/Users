//
//  User.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct UsersInfo: Codable {
    let data: [User]
}

struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
