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
    private let tableViewPlayerCellHeight: CGFloat = 60
    private var team: Team?
    
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
    }
    
    // MARK: - Public properties
    func setupUI(for team: Team) {
        self.team = team
    }
}

extension TeamSquadCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return PlayerType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getViewForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team!.players.filter({
            $0.type == PlayerType.allCases[section]
        }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamPlayerTableViewCell.indetifier, for: indexPath) as! TeamPlayerTableViewCell
        cell.setupUI(with: team!.players[indexPath.row])
        return cell
    }
    
    private func getViewForHeaderInSection(_ section: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor(named: "DarkBlue")
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 50))
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = PlayerType.allCases[section].rawValue
        view.addSubview(label)
        return view
    }
}

// MARK: - Table view delegate
extension TeamSquadCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderForSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewPlayerCellHeight
    }
}
