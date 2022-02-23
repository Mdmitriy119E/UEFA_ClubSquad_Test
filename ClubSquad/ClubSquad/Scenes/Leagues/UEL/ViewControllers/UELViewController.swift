//
//  UELViewController.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class UELViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let tableViewHeaderCellHeight: CGFloat = 286
    private let tableViewCategoriesCellHeight: CGFloat = 44
    private var tableViewCategoryCellHeight: CGFloat = 400
    private let categories =  ["Overview", "Matches", "Groups", "Stats", "Squad"]
    private let team = Team.getMockUELTeam()
    
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
extension UELViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamHeaderTableViewCell.identifier, for: indexPath) as! TeamHeaderTableViewCell
            cell.setupUI(for: team)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamCategoriesTableViewCell.identifier, for: indexPath) as! TeamCategoriesTableViewCell
            cell.setupUI(with: categories)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamCategoryTableViewCell.identifier, for: indexPath) as! TeamCategoryTableViewCell
            cell.setupUI(with: categories, and: team)
            return cell
        }
    }
}

// MARK: - Table view delegate
extension UELViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableViewHeaderCellHeight
        } else if indexPath.row == 1 {
            return tableViewCategoriesCellHeight
        } else {
            return getHeightForSquad()
        }
    }
    
    private func getHeightForSquad() -> CGFloat {
        let sectionHeaderHeight = 50
        let sectionsHeadersHeight = sectionHeaderHeight * PlayerType.allCases.count
        let playerCellHeight = 60
        let playersCellsHeight = playerCellHeight * team.players.count
        let sectionFooterHeight = 8
        let sectionsFooterHeight = sectionFooterHeight * PlayerType.allCases.count
        let tableViewFooterHeight = 84
        return CGFloat(sectionsHeadersHeight + playersCellsHeight + sectionsFooterHeight + tableViewFooterHeight)
    }
}
