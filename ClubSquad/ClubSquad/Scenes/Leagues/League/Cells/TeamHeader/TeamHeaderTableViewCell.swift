//
//  TeamHeaderTableViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamHeaderTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var teamBackground: UIImageView!
    @IBOutlet weak var teamLogo: UIImageView!
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamHeaderTableViewCell.self)
    
    // MARK: - Public methods
    func setupUI(for team: Team) {
        teamBackground.image = team.background
        teamLogo.image = team.logo
    }
}
