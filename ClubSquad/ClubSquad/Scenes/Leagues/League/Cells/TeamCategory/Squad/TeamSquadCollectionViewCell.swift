//
//  SquadCollectionViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamSquadCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let tableViewHeaderForSectionHeight: CGFloat = 50
    private let tableViewFooterForSectionHeight: CGFloat = 8
    private let tableViewPlayerCellHeight: CGFloat = 60
    private var team: Team?
    private var filteredPlayers: [PlayerType: [Player]] = [:]
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamSquadCollectionViewCell.self)
    
    // MARK: - Overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.tableFooterView = getTableViewFooterView()
    }
    
    private func getTableViewFooterView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 84))
        view.backgroundColor = UIColor(named: "LightBlack")
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: tableView.frame.size.width, height: 15))
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "* Player list B"
        view.addSubview(label)
        return view
    }
    
    private func filterPlayers() {
        for playerType in PlayerType.allCases {
            let filteredPlayersByPlayerType = team?.players
                                                .filter({ $0.type == playerType })
                                                .sorted(by: { $0.number < $1.number })
            filteredPlayers[playerType] = filteredPlayersByPlayerType
        }
    }
    
    // MARK: - Public properties
    func setupUI(for team: Team?) {
        self.team = team
        filterPlayers()
    }
    
}

// MARK: - Table view data source
extension TeamSquadCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredPlayers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getViewForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return getViewForFooterInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlayers[PlayerType.allCases[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamPlayerTableViewCell.indetifier, for: indexPath) as! TeamPlayerTableViewCell
        cell.setupUI(with: filteredPlayers[PlayerType.allCases[indexPath.section]]![indexPath.row])
        return cell
    }
    
    private func getViewForHeaderInSection(_ section: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor(named: "DarkBlue")
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 50))
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.text = PlayerType.allCases[section].rawValue
        view.addSubview(label)
        return view
    }
    
    private func getViewForFooterInSection() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 8))
        view.backgroundColor = UIColor(named: "LightBlack")
        return view
    }
}

// MARK: - Table view delegate
extension TeamSquadCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderForSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewFooterForSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewPlayerCellHeight
    }
}
