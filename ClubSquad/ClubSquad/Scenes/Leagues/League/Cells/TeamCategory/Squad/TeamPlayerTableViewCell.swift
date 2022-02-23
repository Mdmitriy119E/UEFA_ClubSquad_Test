//
//  TeamPlayerTableViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamPlayerTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var playerAvatar: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerCountry: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    
    // MARK: - Public properties
    static let indetifier = String(describing: TeamPlayerTableViewCell.self)
    
    // MARK: - Public methods
    func setupUI(with player: Player) {
        playerAvatar.image = player.image
        playerName.text = player.name
        playerCountry.text = player.country
        playerNumber.text = "\(player.number)"
    }
}
