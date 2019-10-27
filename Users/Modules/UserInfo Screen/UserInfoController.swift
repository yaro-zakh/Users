//
//  ViewController.swift
//  Users
//
//  Created by Yaroslav Zakharchuk on 10/26/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class UserInfoController: UIViewController {

    var presenter: UserInfoPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    
    let filterView = FilterDataView()
    let sortButton = UIButton(type: .custom)
    private let cellIdentifier = "UserInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortButton()
        setupFilterView()
        presenter = UserInfoPresenter(with: self)
        presenter.viewDidLoad()
    }
    
    private func setupFilterView() {
        filterView.delegate = self
        let rightBarButton = UIBarButtonItem(customView: filterView)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
        
    private func setupSortButton() {
        sortButton.setImage(UIImage(named: "unsorted"), for: .normal)
        sortButton.addTarget(self, action: #selector(sortButtonAction), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: sortButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func sortButtonAction(_ sender: UIBarButtonItem) {
        presenter.sortedUser()
    }
}

extension UserInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserInfoTableViewCell {
            cell.user = presenter.userData[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension UserInfoController: UserView {
    func reloadView() {
        tableView.reloadData()
    }
    
    func changeSortButtonState(state: SortState) {
        switch state {
        case .unsorted:
            sortButton.setImage(UIImage(named: "unsorted"), for: .normal)
        case .alphabetical:
            sortButton.setImage(UIImage(named: "a-z"), for: .normal)
        case .revesreAlphabetical:
            sortButton.setImage(UIImage(named: "z-a"), for: .normal)
        }
    }
}

extension UserInfoController: FilterView {
    func filterData(first: Character, second: Character) {
        presenter.userData = presenter.dataSource.filter { $0.firstName.contains(first) && $0.firstName.contains(second)}
        tableView.reloadData()
    }
}

