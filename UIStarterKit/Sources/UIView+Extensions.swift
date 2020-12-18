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
    
    public func setBorder(color: UIColor, width: CGFloat =  1.0) {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        layer.borderWidth = width
    }
}

extension UIImageView {
    static func generic(contentMode: UIImageView.ContentMode = .scaleAspectFit, backgroundColor: UIColor = .clear, image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = contentMode
        imageView.backgroundColor = backgroundColor
        imageView.image = image
        return imageView
    }
}
