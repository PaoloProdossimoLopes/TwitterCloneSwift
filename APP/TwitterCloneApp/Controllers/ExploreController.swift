//
//  ExploreController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import Foundation
import UIKit

class ExploreController: UITableViewController {
    
    // MARK: - Properties
    let reuseIdentifier: String = "FindUserTableViewCell"
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredUsers = [String]() {
        didSet{ tableView.reloadData() }
    }
    
    private let defaultUsers: [String] = ["user_one", "user_Two", "user_three", "user_four"]
    
    private var inSearchModel: Bool {
        guard let isEmptyText = searchController.searchBar.text?.isEmpty else { return false }
        return searchController.isActive && !isEmptyText
    }
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureUI()
        
        tableView.register(FindUserCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    

    // MARK: - Helpers
    func configureUI(){
        navigationItem.title = "Explore"
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for user.."
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

extension ExploreController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PerfilViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let user = inSearchModel ? filteredUsers[indexPath.row] : defaultUsers[indexPath.row]
        vc.username = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchModel ? filteredUsers.count : defaultUsers.count
//        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FindUserCell
        let user = inSearchModel ? filteredUsers[indexPath.row] : defaultUsers[indexPath.row]
        cell.usernameLabel.text = user.lowercased()
        return cell
    }
}

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = defaultUsers.filter({ $0.contains(searchText)})
        tableView.reloadData()
    }
}

