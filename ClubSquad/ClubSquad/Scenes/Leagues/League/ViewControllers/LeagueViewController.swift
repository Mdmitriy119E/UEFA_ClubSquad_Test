//
//  UCLViewController.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class LeagueViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let tableViewHeaderCellHeight: CGFloat = 286
    private let tableViewCategoriesCellHeight: CGFloat = 44
    private var isCollapsed = false
    
    // MARK: - Public properties
    var isUELLeague: Bool = false
    var team: Team!
    var categories: [String] = []
    
    // MARK: - Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        addRightBarButtonItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewContentInset()
    }
    
    // MARK: - IBActions
    @objc private func starButtonTapped() {
        isCollapsed = !isCollapsed
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 2, section: 0)],
                             with: isCollapsed ? .top : .bottom)
        tableView.endUpdates()
    }
    
    // MARK: - Private methods
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addRightBarButtonItem() {
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "StarIcon"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(starButtonTapped))
    }
    
    private func setTableViewContentInset() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        tableView.contentInset = UIEdgeInsets(top: -(statusBarHeight + navigationBarHeight), left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Table view data source
extension LeagueViewController: UITableViewDataSource {
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
            cell.delegate = self
            cell.setupUI(with: categories, isUELLeague: isUELLeague)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamCategoryTableViewCell.identifier, for: indexPath) as! TeamCategoryTableViewCell
            cell.delegate = self
            cell.setupUI(with: categories, and: team)
            return cell
        }
    }
}

// MARK: - Table view delegate
extension LeagueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableViewHeaderCellHeight
        } else if indexPath.row == 1 {
            return tableViewCategoriesCellHeight
        } else {
            return isCollapsed ? 0 : getHeightForSquadCell()
        }
    }
    
    private func getHeightForSquadCell() -> CGFloat {
        let sectionHeaderHeight = 50
        let sectionsHeadersHeight = sectionHeaderHeight * PlayerType.allCases.count
        let playerCellHeight = 60
        let playersCellsHeight = playerCellHeight * team.players.count
        let sectionFooterHeight = 24
        let sectionsFooterHeight = sectionFooterHeight * PlayerType.allCases.count
        let tableViewFooterHeight = 84
        return CGFloat(sectionsHeadersHeight + playersCellsHeight + sectionsFooterHeight + tableViewFooterHeight)
    }
}

// MARK: - Table view categories cell delegate
extension LeagueViewController: TableViewCategoryCellDelegate {
    func reloadCategoriesCell(with selectedCategory: Int) {
        let categoriesCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TeamCategoriesTableViewCell
        if (categoriesCell.selectedCategory != selectedCategory) {
            categoriesCell.selectedCategory = selectedCategory
            categoriesCell.collectionView.reloadData()
        }
    }
}

// MARK: - Table view categories cell delegate
extension LeagueViewController: TableViewCategoriesCellDelegate {
    func reloadCategoryCell(with selectedCategory: Int) {
        let categoryCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TeamCategoryTableViewCell
        categoryCell.collectionView.scrollToItem(at: IndexPath(item: selectedCategory, section: 0),
                                                 at: [.centeredVertically, .centeredHorizontally],
                                                 animated: true)
    }
}
