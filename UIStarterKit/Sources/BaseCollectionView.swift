//
//  BaseCollectionView.swift
//  UIStarterKit
//
//  Created by Venkat Krovi on 12/18/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit
public protocol BaseCollectionViewProtocols {
    func registerCells()
    func setCollectionViewDelegateDataSource()
}

public typealias BaseCollectionView = BaseCollectionViewClass & BaseCollectionViewProtocols

open class BaseCollectionViewClass: UIView {
    
    public lazy var collectionView: UICollectionView = UICollectionView.generic()
    public init() {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setSizeClassSpecificConstraints() { }
    
    open func setUIStyle(mode: Theme.Mode?){ }
    
    open func setupView() {
        addSubview(collectionView)
        guard let delegate = self as? BaseCollectionViewProtocols else { return }
        delegate.registerCells()
        delegate.setCollectionViewDelegateDataSource()
    }

    open func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)]
        NSLayoutConstraint.activate(constraints)
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
    
}

extension UICollectionView {
    static func generic(direction: UICollectionView.ScrollDirection = .vertical, minimumLineSpacing: CGFloat = 16.0, minimumInteritemSpacing: CGFloat = 16.0, insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0), allowsSelection: Bool = true, allowsMultipleSelection: Bool = false) -> UICollectionView {
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
public typealias BaseCollectionViewCell = BaseCollectionViewCellClass & BaseViewProtocols

open class BaseCollectionViewCellClass: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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

}
