//
//  ViewController.swift
//  notyng
//
//  Created by João Pedro on 25/04/23.
//

import Foundation
import UIKit

extension UIViewController {
    /// Present a Custom Loader - Animation
    ///
    /// - Parameters:
    ///   - message: The message for Loading
    ///   - imgName: The Image Name for Loading Icon
    func showLoader() {
        let loaderView = LoaderView(frame: self.view.frame)
        self.view.addSubview(loaderView)
    }

    /// Hide the Custom Loader
    ///
    func hideLoader() {
        for view in self.view.subviews {
            if let view = view as? LoaderView {
                view.removeFromSuperview()
                break
            }
        }
    }
}
