//
//  UIView+Extensions.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/20/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

extension UIView {
    
    public func isHorizontalSizeRegular() -> Bool {
        return self.traitCollection.horizontalSizeClass == .regular
    }
    
    public func makeRounded() {
        let minDimension = min(frame.width, frame.height)
        self.layer.cornerRadius = minDimension / 2.0
        self.layer.masksToBounds = true
    }
    
    public func roundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func setTopShadow(color: UIColor = .black, opacity: Float = 0.8, offSet: CGSize = CGSize(width: 0.0, height: -1.0), radius: CGFloat = 1, scale: Bool = true, path: CGPath? = nil) {
        setShadow(color: color, opacity: opacity, offSet: offSet, radius: radius, scale: scale, path: path)
    }
    
    public func setDropShadow(color: UIColor = .black, opacity: Float = 0.8, offSet: CGSize = CGSize(width: 0.0, height: 1.0), radius: CGFloat = 1, scale: Bool = true, path: CGPath? = nil) {
        setShadow(color: color, opacity: opacity, offSet: offSet, radius: radius, scale: scale, path: path)
    }

    private func setShadow(color: UIColor = .black, opacity: Float = 0.8, offSet: CGSize = CGSize(width: 0.0, height: 1.0), radius: CGFloat = 1, scale: Bool = true, path: CGPath? = nil) {
        layer.masksToBounds = false
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = path
    }
    
    public func removeDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = nil
        layer.shouldRasterize = false
        layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.0
        layer.rasterizationScale = 1.0
    }
    
    public func setBorder(color: UIColor) {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1.0
    }
}

extension UICollectionView {
    public static func generic(direction: UICollectionView.ScrollDirection = .vertical, minimumLineSpacing: CGFloat = 16.0, minimumInteritemSpacing: CGFloat = 16.0, insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0), allowsSelection: Bool = true, allowsMultipleSelection: Bool = false) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = insets
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = allowsSelection
        collectionView.allowsMultipleSelection = allowsMultipleSelection
        collectionView.backgroundColor = .clear
        return collectionView
    }
}
