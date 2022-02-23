//
//  UCLViewController.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class UCLViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let tableViewHeaderCellHeight: CGFloat = 286
    private let tableViewCategoriesCellHeight: CGFloat = 44
    private let categories =  ["Overview", "Matches", "Groups", "Stats", "Squad"]
    
    // MARK: - Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewContentInset()
    }
    
    // MARK: - Private methods
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setTableViewContentInset() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        tableView.contentInset = UIEdgeInsets(top: -(statusBarHeight + navigationBarHeight), left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Table view data source
extension UCLViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamHeaderTableViewCell.identifier, for: indexPath) as! TeamHeaderTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamCategoriesTableViewCell.identifier, for: indexPath) as! TeamCategoriesTableViewCell
            cell.setupUI(with: categories)
            return cell
        }
    }
}

// MARK: - Table view delegate
extension UCLViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableViewHeaderCellHeight
        } else {
            return tableViewCategoriesCellHeight
        }
    }
}
