//
//  SearchButton.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 07.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class SearchButton: UIButton {

    private var originalButtonText: String?
    private var activityIndicator: UIActivityIndicatorView!
    
    /// starts activity indicator animating
    func startLoading() {
        originalButtonText = titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
            addSubview(activityIndicator)
            centerActivityIndicatorInButton()
        }
        
        activityIndicator.startAnimating()
    }
    
    /// stops activity indicator animating
    func stopLoading() {
        setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    /// create activity indicator
    ///
    /// - Returns: activity indicator
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
    
    /// activity indicator constraints
    private func centerActivityIndicatorInButton() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
