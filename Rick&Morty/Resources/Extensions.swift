//
//  Extensions.swift
//  Rick&Morty
//
//  Created by sofia on 15.08.2023.
//

import UIKit

///     Extend UIView to make addSubViews a valid function which we call in Characters View
extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
