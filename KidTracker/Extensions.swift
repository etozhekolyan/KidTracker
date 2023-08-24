//
//  Extensions.swift
//  KidTracker
//
//  Created by Nickolay Vasilchenko on 23.08.2023.
//

import Foundation
import UIKit
 
extension UIView {
    
    func fillSuperView() {
        setAnchors(top: superview?.topAnchor,
                   botton: superview?.bottomAnchor,
                   left: superview?.leadingAnchor,
                   right: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setAnchors(top: NSLayoutYAxisAnchor?, botton: NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let botton = botton {
            bottomAnchor.constraint(equalTo: botton, constant: -padding.bottom).isActive = true
        }
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
