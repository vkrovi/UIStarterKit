//
//  Theme.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/12/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

public struct Theme {
    public enum Mode {
        case light
        case dark
    }
    
    public static func mode(userInterfaceStyle: UIUserInterfaceStyle) -> Mode {
        return userInterfaceStyle == .dark ? .dark : .light
    }
    
    public struct Light {
        
        static let textColor : UIColor = UIColor.darkText
        static let primaryButtonTitleColor : UIColor =  UIColor.darkText
        static let primaryButtonHighlightedTitleColor : UIColor = UIColor.darkText
        static let primaryButtonBackgroundColor : UIColor = UIColor.clear
        
        static let primaryButtonHighlightedBackgroundColor : UIColor = UIColor.lightGray
            
        static let secondaryButtonTitleColor : UIColor =  UIColor.darkText
          
        static let secondaryButtonHighlightedTitleColor : UIColor = UIColor.black
    }
    
    public struct Dark {
        static let tableCellBorderColor: UIColor =  UIColor.lightGray
        
        static let textColor : UIColor = UIColor.lightText
        static let primaryButtonTitleColor : UIColor = UIColor.lightText
        static let primaryButtonHighlightedTitleColor : UIColor = UIColor.lightText
        
        static let primaryButtonBackgroundColor : UIColor =  UIColor.clear
        
        static let primaryButtonHighlightedBackgroundColor : UIColor = UIColor.darkGray
        
        static let secondaryButtonTitleColor : UIColor = UIColor.lightText
        
        static let secondaryButtonHighlightedTitleColor : UIColor =  UIColor.white
    }
}

public struct Dimens {
    public struct Common {
        
        static let transparentNavBacgroundColor = UIColor.clear
        static let screenTitleFont = UIFont.preferredFont(forTextStyle: .headline)
        static let cellBorderThickness = 0.5
        static let pillarWidth = 500.0
        static let padding: CGFloat = 16.0
        static let paddingHalf: CGFloat = 8.0
        static let screenTextFont = UIFont.preferredFont(forTextStyle: .body)
        static let screenSmallFont = UIFont.preferredFont(forTextStyle: .subheadline)
        static let actionButtonFont = UIFont.preferredFont(forTextStyle: .body)
        static let secondaryButtonFont = UIFont.preferredFont(forTextStyle: .callout)
        static let buttonHeight = 32.0
    }
}
