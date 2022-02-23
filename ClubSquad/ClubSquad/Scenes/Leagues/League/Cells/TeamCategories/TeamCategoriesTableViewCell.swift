//
//  CategoriesTableViewCell.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

protocol TableViewCategoriesCellDelegate: AnyObject {
    func reloadCategoryCell(with selectedCategory: Int)
}

class TeamCategoriesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private let minimumInterSpacing: CGFloat = 16
    private let collectionViewCellHeight: CGFloat = 44
    private var categories: [String] = []
    private var isUELLeague: Bool = false
    
    // MARK: - Public properties
    static let identifier = String(describing: TeamCategoriesTableViewCell.self)
    weak var delegate: TableViewCategoriesCellDelegate?
    var selectedCategory = 0
    
    // MARK: - Overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSectionInsetForCollectionView()
    }
    
    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateSectionInsetForCollectionView() {
        let categoriesWidth = getWidthForCategories()
        let collectionViewWidth = collectionView.frame.size.width
        if categoriesWidth + 2 * minimumInterSpacing < collectionViewWidth {
            let horizontalMargin = (collectionViewWidth - categoriesWidth) / 2
            collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalMargin, bottom: 0, right: horizontalMargin)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: minimumInterSpacing, bottom: 0, right: minimumInterSpacing)
        }
    }
    
    private func getWidthForCategories() -> CGFloat{
        var width: CGFloat = 0
        categories.forEach { width += $0.width }
        width += minimumInterSpacing * CGFloat((categories.count - 1))
        return width
    }
    
    // MARK: - Public methods
    func setupUI(with categories: [String], isUELLeague: Bool) {
        self.categories = categories
        self.isUELLeague = isUELLeague
    }
}

// MARK: - Collection view data source
extension TeamCategoriesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCategoryCollectionViewCell.identifier, for: indexPath) as! TeamCategoryCollectionViewCell
        cell.setUI(with: categories[indexPath.item],
                   isSelected: indexPath.item == selectedCategory,
                   isUELLeague: isUELLeague)
        return cell
    }
}

// MARK: - Collection view delegate
extension TeamCategoriesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.reloadCategoryCell(with: indexPath.item)
    }
}

// MARK: - Collection view delegate flow layout
extension TeamCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentCategory = categories[indexPath.item]
        return CGSize(width: currentCategory.width, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterSpacing
    }
}
