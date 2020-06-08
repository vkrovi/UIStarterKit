//
//  ActionButtonTheme.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/20/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

public struct ActionButtonTheme {
    let initalBackgroundColor: UIColor
    let disabledBackgroundColor: UIColor?
    let selectedBackgroundColor: UIColor?
    let highlightedBackgroundColor: UIColor?
    let selectedStateHighlightedBackgroundColor: UIColor?
    let titleFont: UIFont
    let titleColor: UIColor
    let titleHighlightedTextColor: UIColor?
    let isRounded: Bool?
    let border: Bool
    let selectedTitleColor: UIColor
    
    public static func primary(mode: Theme.Mode) -> ActionButtonTheme {
        return mode == .light ? primaryLightTheme() : primaryDarkTheme()
    }
    public static func secondary(mode: Theme.Mode) -> ActionButtonTheme {
        return mode == .light ? secondaryLightTheme() : secondaryDarkTheme()
    }

    private static func primaryLightTheme() -> ActionButtonTheme {
        return ActionButtonTheme(initalBackgroundColor: Theme.Light.primaryButtonBackgroundColor,
                                 disabledBackgroundColor: nil,
                                 selectedBackgroundColor: Theme.Light.primaryButtonHighlightedBackgroundColor,
                                 highlightedBackgroundColor: nil,
                                 selectedStateHighlightedBackgroundColor: nil,
                                 titleFont: Dimens.Common.actionButtonFont,
                                 titleColor: Theme.Light.primaryButtonTitleColor,
                                 titleHighlightedTextColor: Theme.Light.primaryButtonHighlightedTitleColor,
                                 isRounded: false,
                                 border: false,
                                 selectedTitleColor: .black)
    }
    
    private static func primaryDarkTheme() -> ActionButtonTheme {
        return ActionButtonTheme(initalBackgroundColor: Theme.Dark.primaryButtonBackgroundColor,
                                 disabledBackgroundColor: nil,
                                 selectedBackgroundColor: nil,
                                 highlightedBackgroundColor: Theme.Dark.primaryButtonHighlightedBackgroundColor,
                                 selectedStateHighlightedBackgroundColor: nil,
                                 titleFont: Dimens.Common.actionButtonFont,
                                 titleColor: Theme.Dark.primaryButtonTitleColor,
                                 titleHighlightedTextColor: Theme.Dark.primaryButtonHighlightedTitleColor,
                                 isRounded: false,
                                 border: false,
                                 selectedTitleColor: .lightText)
    }
    
    private static func secondaryLightTheme() -> ActionButtonTheme {
        return ActionButtonTheme(initalBackgroundColor: .clear,
                                 disabledBackgroundColor: nil,
                                 selectedBackgroundColor: .clear,
                                 highlightedBackgroundColor: .clear,
                                 selectedStateHighlightedBackgroundColor: .clear,
                                 titleFont: Dimens.Common.secondaryButtonFont,
                                 titleColor: Theme.Light.secondaryButtonTitleColor,
                                 titleHighlightedTextColor: Theme.Light.secondaryButtonHighlightedTitleColor,
                                 isRounded: false,
                                 border: false,
                                 selectedTitleColor: .white)
    }
    
    private static func secondaryDarkTheme() -> ActionButtonTheme {
        return ActionButtonTheme(initalBackgroundColor: .clear,
                                 disabledBackgroundColor: nil,
                                 selectedBackgroundColor: .clear,
                                 highlightedBackgroundColor: .clear,
                                 selectedStateHighlightedBackgroundColor: .clear,
                                 titleFont: Dimens.Common.secondaryButtonFont,
                                 titleColor: Theme.Dark.secondaryButtonTitleColor,
                                 titleHighlightedTextColor: Theme.Dark.secondaryButtonHighlightedTitleColor,
                                 isRounded: false,
                                 border: false,
                                 selectedTitleColor: .white)
    }
}
