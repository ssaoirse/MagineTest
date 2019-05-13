//
//  ShowListInteractor.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation

/// The Show List Interactor
class ShowListInteractor {
    
    // Web Service Provider.
    private let webServiceProvider: WebServiceProvider
    private weak var searchListView: ShowListDisplayable?
    
    // Search Results
    private var searchResults = [ListItem]()
    
    /// Initializer:
    init(urlSession: URLSession,
         searchListView: ShowListDisplayable?) {
        self.webServiceProvider = WebServiceProvider(urlSession: urlSession)
        self.searchListView = searchListView
    }
}


// MARK:- ShowList Business Logic
extension ShowListInteractor: ShowListBusinessLogic {
    
    // Search and fetch list of shows.
    func searchShows(with searchText: String) {
        
        // Validate site name.
        let trimmedText = searchText.trim()
        if trimmedText.count == 0 {
            let viewModel = AppModels.Error(title: "Search", message: "Please enter a valid search text.")
            self.searchListView?.display(error: viewModel)
            return
        }
        self.searchListView?.showActivity(with: nil)
        
        let serviceRequest = SearchShowsRequest.searchList(searchText: trimmedText)
        webServiceProvider.performService(serviceRequest: serviceRequest) { [weak self] (result) in
            self?.searchListView?.hideActivity()
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    self?.searchResults.removeAll()
                    let items = try jsonDecoder.decode([ListItem].self, from: data)
                    self?.searchResults.append(contentsOf: items)
                    self?.searchListView?.showSearchResult(items)
                }
                catch {
                    self?.searchListView?.showRetrySearchAlert(with: error.localizedDescription)
                }
                return
            case .failure(let errorMessage):
                self?.searchListView?.showRetrySearchAlert(with: errorMessage)
                return
            }
        }
    }
    
    // Fetch Image:
    func fetchImage(for index: Int) {
        
        // Validate index.
        if index >= self.searchResults.count {
            return
        }
        
        // Get the item from the result.
        var item = self.searchResults[index]
        switch item.show.downloadStatus {
            case .inProgress, .error:
                return
            case .done:
                return
            case .todo:
                item.show.downloadStatus = .inProgress
                self.searchResults[index] = item
        }
        
        guard let imageUrl = item.show.image?.medium else { return }
        let serviceRequest = SearchShowsRequest.fetchImage(imageUrl: imageUrl)
        webServiceProvider.performService(serviceRequest: serviceRequest) { [weak self] (result) in
            self?.searchListView?.hideActivity()
            switch result {
            case .success(let data):
                // Set the image data for the List item with the current image URL.
                if var item = self?.searchResults[index] {
                    item.show.downloadStatus = .done
                    item.show.imageData = data
                    self?.searchResults[index] = item
                    self?.searchListView?.refreshListItem(item, for: index)
                }
                return
            case .failure:
                if var item = self?.searchResults[index] {
                    item.show.downloadStatus = .error
                    self?.searchResults[index] = item
                }
                return
            }
        }
    }
    
    
    // Getter:
    func getSearchResult() -> [ListItem] {
        return self.searchResults
    }
    
}
