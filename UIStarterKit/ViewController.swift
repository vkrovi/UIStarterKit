//
//  ViewController.swift
//  UIStarterKit
//
//  Created by Venkat Krovi on 5/29/20.
//  Copyright © 2020 110DigitalLabs. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    func assignView() {
        let thisView = UIView()
        thisView.backgroundColor = .red
        self.view = thisView
    }
}

