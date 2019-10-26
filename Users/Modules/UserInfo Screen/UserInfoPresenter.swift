//
//  UserInfoPresenter.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol UserView: class {
    func reloadView()
}

final class UserInfoPresenter {
    
    private weak var view: UserView?
    private var apiService: ApiServiceConfigurable
    
    var dataSource = [User]()
    var numberOfItems: Int {
        return dataSource.count
    }
    
    init(with view: UserView) {
        self.view = view
        
        let networkManager = NetworkManager()
        self.apiService = ApiService(apiManager: networkManager)
    }
    
    func viewDidLoad() {
        loadDataFromAPI()
    }
    
    func viewWillAppear() {
        view?.reloadView()
    }
    
    private func loadDataFromAPI() {
        apiService.fetchUsers { [weak self] usersInfo, error in
            guard let self = self else { return }
            if let usersInfo = usersInfo {
                self.dataSource = usersInfo.data
                DispatchQueue.main.async {
                    self.view?.reloadView()
                }
            }
        }
    }
}
