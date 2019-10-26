//
//  NetworkManager.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let scheme = "https"
    private let host = "reqres.in"
    private let path = "/api/users"
    private let urlSession = URLSession.shared
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
        URLQueryItem(name: "page", value: "2")
        ]
        return urlComponents
    }
    
    func searchObject(completion: @escaping(Data?, Error?) -> Void) {
        let components = self.urlComponents
        guard let url = components.url else {
            completion(nil, NSError(domain: "", code: 100, userInfo: nil))
            return
        }
        urlSession.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }.resume()
    }
}
