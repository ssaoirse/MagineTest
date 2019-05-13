//
//  AppDisplayable.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation
import UIKit

enum AppModels {
    
    struct Error {
        let title: String
        let message: String?
    }
}

protocol AppDisplayable {
    func display(error: AppModels.Error)
    func showActivity(with message: String?)
    func hideActivity()
}

extension AppDisplayable where Self: UIViewController {
    
    func display(error: AppModels.Error) {
        DispatchQueue.main.async {
            let message = error.message ?? " "
            self.errorMessageWithTitle(title: error.title, message: message)
        }
    }
    
    func showActivity(with message: String?) {
        let msg = message ?? ""
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            if msg.count > 0 {
                self.showWaitOverlayWithText(msg)
            }else {
                self.showWaitOverlay()
            }
        }
    }
    
    func hideActivity() {
        DispatchQueue.main.async {
            self.removeAllOverlays()
            self.view.isUserInteractionEnabled = true
        }
    }
}
