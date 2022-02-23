//
//  TeamCategoryCollectionViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamCategoryCollectionViewCell.self)
    
    // MARK: - Public methods
    func setUI(with category: String) {
        categoryName.text = category
    }
}
