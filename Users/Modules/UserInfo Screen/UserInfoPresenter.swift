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
    func changeSortButtonState(state: SortState)
    func endRefreshing()
}

enum SortState {
    case unsorted
    case alphabetical
    case revesreAlphabetical
}

final class UserInfoPresenter {
    
    private weak var view: UserView?
    private var apiService: ApiServiceConfigurable
    var sortState: SortState = .unsorted
    
    var dataSource = [User]()
    var userData = [User]()
    var numberOfItems: Int {
        return userData.count
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
    
    func sortedUser() {
        switch sortState {
        case .unsorted:
            userData = dataSource.sorted(by: {$0.firstName < $1.firstName})
            sortState = .alphabetical
        case .alphabetical:
            userData = dataSource.sorted(by: {$0.firstName > $1.firstName})
            sortState = .revesreAlphabetical
        case .revesreAlphabetical:
            userData = dataSource
            sortState = .unsorted
        }
        view?.changeSortButtonState(state: sortState)
        view?.reloadView()
    }
    
    private func loadDataFromAPI() {
        apiService.fetchUsers { [weak self] usersInfo, error in
            guard let self = self else { return }
            if let usersInfo = usersInfo {
                self.dataSource = usersInfo.data
                self.userData = usersInfo.data
                DispatchQueue.main.async {
                    self.view?.endRefreshing()
                    self.view?.reloadView()
                }
            }
        }
    }
}
