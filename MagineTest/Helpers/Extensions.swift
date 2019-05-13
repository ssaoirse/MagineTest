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
