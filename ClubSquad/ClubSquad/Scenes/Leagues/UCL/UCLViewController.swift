//
//  UCLViewController.swift
//  ClubSquad
//
//  Created by Dumitru Manea on 23.02.2022.
//

import UIKit

class UCLViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let tableViewHeaderHeight: CGFloat = 286
    
    // MARK: - Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewContentInset()
    }
    
    // MARK: - Private methods
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setTableViewContentInset() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        tableView.contentInset = UIEdgeInsets(top: -(statusBarHeight + navigationBarHeight), left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Table view data source
extension UCLViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamHeaderTableViewCell.identifier, for: indexPath) as! TeamHeaderTableViewCell
        return cell
    }
}

// MARK: - Table view delegate
extension UCLViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeaderHeight
    }
}
