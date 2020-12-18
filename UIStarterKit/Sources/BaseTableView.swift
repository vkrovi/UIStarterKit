//
//  BaseTableView.swift
//  UIStarterKit
//
//  Created by Venkat Krovi on 12/18/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

public protocol BaseTableViewProtocols {
    func registerCells()
    func setTableDelegateDataSource()
}

public typealias BaseTableView = BaseTableViewClass & BaseTableViewProtocols

open class BaseTableViewClass: UIView {
    
    public lazy var tableView: UITableView = UITableView.generic(style: self.tableViewStyle)
    let tableViewStyle: UITableView.Style
    public init(tableViewStyle: UITableView.Style) {
        self.tableViewStyle = tableViewStyle
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
        addSubview(tableView)
        guard let delegate = self as? BaseTableViewProtocols else { return }
        delegate.registerCells()
        delegate.setTableDelegateDataSource()
    }

    open func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)]
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

extension UITableView {
    public static func generic(style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        return tableView
    }
}

public typealias BaseTableViewCell = BaseTableViewCellClass & BaseViewProtocols

open class BaseTableViewCellClass: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
