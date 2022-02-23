//
//  CategoriesTableViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class TeamCategoriesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private let minimumInterSpacing: CGFloat = 16
    private let collectionViewCellHeight: CGFloat = 44
    private var categories: [String] = []
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamCategoriesTableViewCell.self)
    
    // MARK: - Overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    // MARK: - Private methods
    private func setupCollectionView() {
        #warning("Adjust content inset for collection view to be in the middle of the screen")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Public methods
    func setupUI(with categories: [String]) {
        self.categories = categories
    }
}

// MARK: - Collection view data source
extension TeamCategoriesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCategoryCollectionViewCell.identifier, for: indexPath) as! TeamCategoryCollectionViewCell
        cell.setUI(with: categories[indexPath.item])
        return cell
    }
}

// MARK: - Collection view delegate
extension TeamCategoriesTableViewCell: UICollectionViewDelegate { }

// MARK: - Collection view delegate flow layout
extension TeamCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentCategory = categories[indexPath.item]
        return CGSize(width: getWidth(of: currentCategory), height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterSpacing
    }
    
    private func getWidth(of category: String) -> CGFloat {
        let categorySize = category.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
        ])
        return categorySize.width
    }
}
