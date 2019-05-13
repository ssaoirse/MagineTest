//
//  Extensions.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//


import Foundation
import UIKit

// MARK:- String -
extension String
{
    // trim leading/trailing whitespaces.
    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    // URL encodes string passed (space with %20)
    public func urlPathEncoded() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    }
}

// MARK:- UIViewController.
extension UIViewController {
    
    public func errorMessageWithTitle(title: String, message : String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) {
            (action: UIAlertAction) in //print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


// MARK:- UITableView
extension UITableView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y,
                                             width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .black
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
    }
    func restore() {
        self.backgroundView = nil
    }
}
