//
//  ShowListTableViewCell.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import UIKit

class ShowListTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var showImageView: UIImageView!

    func configureCell(with item: ListItem, index: Int, and interactor: ShowListBusinessLogic) {
        self.nameLabel.text = item.show.name
        switch item.show.downloadStatus {
        case .todo:
            interactor.fetchImage(for: index)
            self.showImageView.image = UIImage(named: "Placeholder")

        case .done:
            guard let data = item.show.imageData else {
                self.showImageView.image = UIImage(named: "Placeholder")
                return
            }
            self.showImageView.image = UIImage.init(data: data)
            
        default:
            self.showImageView.image = UIImage(named: "Placeholder")
        }
        
    }
}
