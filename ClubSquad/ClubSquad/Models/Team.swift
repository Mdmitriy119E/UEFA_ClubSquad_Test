//
//  Team.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

struct Team {
    let name: String
    let logo: UIImage
    let background: UIImage
    let players: [Player]
}

// MARK: - Mock data
extension Team {
    static func getMockUCLTeam() -> Team {
        var players: [Player] = []
        for _ in 0..<5 {
            for playerType in PlayerType.allCases {
                let player = Player(image: UIImage(named: "MessiAvatar")!,
                                    name: "Player name",
                                    country: "Country",
                                    number: 24,
                                    type: playerType)
                players.append(player)
            }
        }
        let team = Team(name: "Barcelona",
                        logo: UIImage(named: "BarcelonaLogo")!,
                        background: UIImage(named: "BarcelonaUCLBackgroundImage")!,
                        players: players)
        return team
    }
    
    static func getMockUELTeam() -> Team {
        var players: [Player] = []
        for _ in 0..<5 {
            for playerType in PlayerType.allCases {
                let player = Player(image: UIImage(named: "MessiAvatar")!,
                                    name: "Player name",
                                    country: "Country",
                                    number: 24,
                                    type: playerType)
                players.append(player)
            }
        }
        let team = Team(name: "Barcelona",
                        logo: UIImage(named: "BarcelonaLogo")!,
                        background: UIImage(named: "BarcelonaUELBackgroundImage")!,
                        players: players)
        return team
    }
}
