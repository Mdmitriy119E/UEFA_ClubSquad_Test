//
//  TeamCategoryTableViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamCategoryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private var allCategories: [String] = []
    private var team: Team!
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamCategoryTableViewCell.self)
    
    // MARK: - Overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    // MARK: - Public methods
    func setupUI(with allCategories: [String], and team: Team) {
        self.allCategories = allCategories
        self.team = team
    }
    
    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Collection view data source
extension TeamCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamOverviewCollectionViewCell.identifier, for: indexPath) as! TeamOverviewCollectionViewCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamMatchesCollectionViewCell.identifier, for: indexPath) as! TeamMatchesCollectionViewCell
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamGroupsCollectionViewCell.identifier, for: indexPath) as! TeamGroupsCollectionViewCell
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamStatsCollectionViewCell.identifier, for: indexPath) as! TeamStatsCollectionViewCell
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamSquadCollectionViewCell.identifier, for: indexPath) as! TeamSquadCollectionViewCell
                cell.setupUI(for: team)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamOverviewCollectionViewCell.identifier, for: indexPath) as! TeamOverviewCollectionViewCell
                return cell
        }
    }
}

// MARK: - Collection view delegate
extension TeamCategoryTableViewCell: UICollectionViewDelegate { }

// MARK: - Collection view delegate flow layout
extension TeamCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
