//
//  ShowDetailsViewController.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var showImageView: UIImageView!
    @IBOutlet fileprivate weak var typeLabel: UILabel!
    @IBOutlet fileprivate weak var languageLabel: UILabel!
    @IBOutlet fileprivate weak var scoreLabel: UILabel!
    
    // MARK: - Variables
    var listItem: ListItem? = nil
    
    // MARK: - Initiating view controller
    class func initiateVC() -> ShowDetailsViewController {
        guard let detailsVC =
            UIStoryboard(name: "Main",
                         bundle: nil).instantiateViewController(withIdentifier: "ShowDetailsViewController")
                as? ShowDetailsViewController else {
                    return ShowDetailsViewController()
        }
        return detailsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.nameLabel.text = listItem?.show.name
        self.typeLabel.text = listItem?.show.type
        self.languageLabel.text = listItem?.show.language
        self.scoreLabel.text = String(format: "%.2f", listItem?.score ?? "-")
        
        guard let data = listItem?.show.imageData else {
            self.showImageView.image = UIImage(named: "Placeholder")
            return
        }
        self.showImageView.image = UIImage.init(data: data)
    }
    
}
