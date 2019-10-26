//
//  ApiService.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol ApiServiceConfigurable {
    func fetchUsers(completion: @escaping (_ usersInfo: UsersInfo?, _ error: Error?) -> Void)
}

final class ApiService: ApiServiceConfigurable {
    private var apiManager: NetworkManager
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }
    
    func fetchUsers(completion: @escaping (UsersInfo?, Error?) -> Void) {
        apiManager.searchObject { (data, error) in
            if let data = data {
                guard let usersInfo = try? JSONDecoder().decode(UsersInfo.self, from: data) else {
                    print("Error: can't parse UsersInfo")
                    completion(nil, error)
                    return
                }
                completion(usersInfo, nil)
            } else if error != nil {
                print(error?.localizedDescription ?? "no Description")
                completion(nil, error)
                return
            }
        }
    }
}
