//
//  ActionButton.swift
//  iCalm
//
//  Created by Venkat Krovi on 1/17/20.
//  Copyright © 2020 ICalm. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    private var initalBackgroundColor: UIColor
    private var disabledBackgroundColor: UIColor
    private var selectedBackgroundColor: UIColor
    private var highlightedBackgroundColor: UIColor
    private var selectedStateHighlightedBackgroundColor: UIColor
    private var titleFont: UIFont
    private var titleColor: UIColor
    private var titleHighlightedTextColor: UIColor
    private var selectedTitleColor: UIColor
    private var isRounded: Bool = false {
        didSet {
            if self.isRounded {
                makeRounded()
            }
        }
    }
    var leftAlignImage: Bool = false
    var border: Bool
    
    init(withTheme theme:ActionButtonTheme) {
        self.initalBackgroundColor = theme.initalBackgroundColor
        self.disabledBackgroundColor = theme.disabledBackgroundColor ?? theme.initalBackgroundColor
        let selectedBackground = theme.selectedBackgroundColor ?? theme.initalBackgroundColor
        self.selectedBackgroundColor = selectedBackground
        self.highlightedBackgroundColor = theme.highlightedBackgroundColor ?? selectedBackground
        self.selectedStateHighlightedBackgroundColor = theme.selectedStateHighlightedBackgroundColor ?? selectedBackground
        self.titleFont = theme.titleFont
        self.titleColor = theme.titleColor
        self.titleHighlightedTextColor = theme.titleHighlightedTextColor ?? theme.titleColor
        self.border = theme.border
        self.selectedTitleColor = theme.selectedTitleColor
        super.init(frame: .zero)
        isRounded = theme.isRounded ?? false
        setupButton()
    }
    
    func updateTheme(withTheme theme:ActionButtonTheme) {
        self.initalBackgroundColor = theme.initalBackgroundColor
        self.disabledBackgroundColor = theme.disabledBackgroundColor ?? theme.initalBackgroundColor
        let selectedBackground = theme.selectedBackgroundColor ?? theme.initalBackgroundColor
        self.selectedBackgroundColor = selectedBackground
        self.highlightedBackgroundColor = theme.highlightedBackgroundColor ?? selectedBackground
        self.selectedStateHighlightedBackgroundColor = theme.selectedStateHighlightedBackgroundColor ?? selectedBackground
        self.titleFont = theme.titleFont
        self.titleColor = theme.titleColor
        self.titleHighlightedTextColor = theme.titleHighlightedTextColor ?? theme.titleColor
        self.border = theme.border
        self.selectedTitleColor = theme.selectedTitleColor
        isRounded = theme.isRounded ?? false
        setupButton()
    }
    
    func setupButton() {
        backgroundColor = initalBackgroundColor
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleHighlightedTextColor, for: .highlighted)
        setTitleColor(selectedTitleColor, for: .selected)
        titleLabel?.font = titleFont
        titleLabel?.allowsDefaultTighteningForTruncation = true
        titleLabel?.adjustsFontSizeToFitWidth = true
        if self.border {
            setBorder(color: self.titleColor)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shoudPreserveSelectedState = false
    
    override var isHighlighted: Bool {
        didSet {
            setHighlight()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            setSelected()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isRounded {
            makeRounded()
        }
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        guard let title = self.attributedTitle(for: state) else {
            super.setTitleColor(color, for: state)
            return
        }
        setAttributedTitle(title, for: state)
    }
    
    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        guard let nonNilTitle = title else {
            super.setAttributedTitle(title, for: state)
            return
        }
        let attributedTitle: NSMutableAttributedString = NSMutableAttributedString(attributedString: nonNilTitle)
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor, range: NSRange(location: 0, length: nonNilTitle.string.count))
        
        super.setAttributedTitle(attributedTitle, for: state)
    }
    
    func setHighlight() {
        if shoudPreserveSelectedState {
            backgroundColor = highlightedBackgroundColor
            setTitleColor(titleHighlightedTextColor, for: .normal)
            return
        }
        
        if isSelected {
            backgroundColor = isHighlighted ? selectedStateHighlightedBackgroundColor : selectedBackgroundColor
        } else {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : initalBackgroundColor
        }
    }
    
    func setSelected() {
        backgroundColor = selectedBackgroundColor
    }
    
    func setDisabled() {
        backgroundColor = disabledBackgroundColor
    }
    
    func setDefault() {
        backgroundColor = initalBackgroundColor
    }
}

extension ActionButton {
    static func primary(mode: Theme.Mode, title: String? = nil) -> ActionButton {
        let button = ActionButton(withTheme: .primary(mode: mode))
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        return button
    }
    
    static func secondary(mode: Theme.Mode, title: String? = nil, alignment: UIControl.ContentHorizontalAlignment = .center) -> ActionButton {
        let button = ActionButton(withTheme: .secondary(mode: mode))
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        button.contentHorizontalAlignment = alignment        
        return button
        
    }
}
