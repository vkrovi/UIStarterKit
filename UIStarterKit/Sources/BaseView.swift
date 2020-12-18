//
//  BaseView.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/17/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

public protocol BaseViewProtocols {
    func setupView()
    func setupLayout()
}
public typealias BaseView = BaseViewClass & BaseViewProtocols

open class BaseViewClass: UIView {
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        guard let delegate = self as? BaseViewProtocols else { return }
        delegate.setupView()
        delegate.setupLayout()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
            self.traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            setSizeClassSpecificConstraints()
        }
        if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            setUIStyle(mode: Theme.mode(userInterfaceStyle: self.traitCollection.userInterfaceStyle))
        }
    }
    public func setSizeClassSpecificConstraints() { }
    
    public func setUIStyle(mode: Theme.Mode?) { }
    
}
