//
//  BaseViewController.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/12/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

public protocol BaseViewControllerProtocols {
    func assignView()
}

public typealias BaseViewController = BaseViewControllerClass & BaseViewControllerProtocols

open class BaseViewControllerClass: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func loadView() {
        super.loadView()
        guard let delegate = self as? BaseViewControllerProtocols else { return }
        delegate.assignView()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
