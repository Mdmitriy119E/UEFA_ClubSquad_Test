//
//  Player.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

struct Player {
    let image: UIImage
    let name: String
    let country: String
    let number: Int
    let type: PlayerType
}

enum PlayerType {
    case goalkeeper
    case defender
    case midfieldier
    case forward
    case coach
}
