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
    
    private let refreshControl = UIRefreshControl()
    private let cellIdentifier = "UserInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortButton()
        setupFilterView()
        tableView.refreshControl = refreshControl
        configureRefreshControl()
        presenter = UserInfoPresenter(with: self)
        presenter.viewDidLoad()
    }
    
    private func configureRefreshControl() {
        let color = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        
        refreshControl.addTarget(self, action: #selector(refreshUserData(_:)), for: .valueChanged)
        refreshControl.tintColor = color
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching User Data ...", attributes: attributes)
    }
    
    @objc private func refreshUserData(_ sender: Any) {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.userData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension UserInfoController: UserView {
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
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
    func filterData(first: String, second: String) {
        presenter.userData = presenter.dataSource.filter { $0.firstName.localizedStandardContains(first) && $0.firstName.localizedStandardContains(second)}
        tableView.reloadData()
    }
}
