//
//  UIColor+Extensions.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/13/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

extension UIColor {
    public func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
    
    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    public static func hexStringToUIColor (hex:String) -> UIColor? {
        let cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
                                .uppercased()
                                .replacingOccurrences(of: "#", with: "")
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        if cString.count == 6 {
            let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(rgbValue & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: 1.0)

        } else if cString.count == 8 {
            let r = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            let g = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            let b = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            let a = CGFloat(rgbValue & 0x000000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: a)
        } else {
            return nil
        }
    }
}
