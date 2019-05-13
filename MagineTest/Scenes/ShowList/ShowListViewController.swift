//
//  ShowListViewController.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController, AppDisplayable {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var showsSearchBar: UISearchBar!
    @IBOutlet fileprivate weak var showsTableView: UITableView!
    
    /// The Interactor.
    private lazy var showListInteractor: ShowListBusinessLogic = ShowListInteractor(urlSession: URLSession.shared,
                                                                                    searchListView: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK:- ShowListDisplayable.
extension ShowListViewController: ShowListDisplayable {
    
    func showSearchResult(_ result: [ListItem]) {
        DispatchQueue.main.async {
            self.showsSearchBar.text = ""
            if result.count == 0 {
                self.showsTableView.setEmptyView(message: "No shows found.")
            }
            else {
                self.showsTableView.restore()
            }
            self.showsTableView.reloadData()
        }
    }
    
    func refreshListItem(_ item: ListItem, for index: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: index, section: 0)
            self.showsTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
    
    func showRetrySearchAlert(with error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Search",
                                                    message: "\(error). Retry?",
                                                    preferredStyle: .alert)
            
            // Ok.
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                if let searchText = self.showsSearchBar?.text {
                    self.showListInteractor.searchShows(with: searchText)
                }
            }
            alertController.addAction(OKAction)
            
            // Cancel
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                // do nothing.
            }
            alertController.addAction(cancelAction)
            
            // Present Dialog message
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    // Navigate to details screen
    func moveToDetailsScreen(with index: Int) {
        let allItems = self.showListInteractor.getSearchResult()
        if index < allItems.count {
            let selectedItem = allItems[index]
            let detailVC = ShowDetailsViewController.initiateVC()
            detailVC.listItem = selectedItem
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


// MARK: - UISearchbar delegate
extension ShowListViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            self.showListInteractor.searchShows(with: searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension ShowListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ShowListTableViewCell", for: indexPath) as?
            ShowListTableViewCell
            else { return UITableViewCell() }
        
        let listItem = self.showListInteractor.getSearchResult()[indexPath.row]
        cell.configureCell(with: listItem, index: indexPath.row, and: self.showListInteractor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showListInteractor.getSearchResult().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToDetailsScreen(with: indexPath.row)
    }
}
