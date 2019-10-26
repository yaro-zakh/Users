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
    @IBOutlet weak var sortButton: UIButton!
    
    private let cellIdentifier = "UserInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UserInfoPresenter(with: self)
        presenter.viewDidLoad()
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        presenter.sortedUser()
    }
}

extension UserInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserInfoTableViewCell {
            cell.user = presenter.dataSource[indexPath.row]
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

