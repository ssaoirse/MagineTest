//
//  ShowListInterfaces.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation

/// Interactor:
protocol ShowListBusinessLogic {
    func searchShows(with searchText: String)
    func fetchImage(for index: Int)
    
    // Getter.
    func getSearchResult() -> [ListItem]
}

// View:
protocol ShowListDisplayable: class, AppDisplayable {
    func showSearchResult(_ result: [ListItem])
    func refreshListItem(_ item: ListItem, for index: Int)
    func showRetrySearchAlert(with error: String)
    func moveToDetailsScreen(with index: Int)
}

/// Default Implementation:
extension ShowListDisplayable {
    // Do Nothing.
    func showSearchResult(_ result: [ListItem]) {}
    func refreshListItem(_ item: ListItem, for index: Int) {}
    func showRetrySearchAlert(with error: String) {}
    func moveToDetailsScreen(with index: Int) {}
}


