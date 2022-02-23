//
//  SelectLeagueViewController.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class SelectLeagueViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUCL" {
            let vc = segue.destination as! LeagueViewController
            vc.team = Team.getMockUCLTeam()
            vc.categories = ["Overview", "Matches", "Groups", "Stats", "Squad"]
        } else if segue.identifier == "toUEL" {
            let vc = segue.destination as! LeagueViewController
            vc.isUELLeague = true
            vc.team = Team.getMockUELTeam()
            vc.categories = ["Overview", "Matches", "Groups", "Stats", "Squad"]
        }
    }
}
