//
//  ViewController.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import UIKit
import MVVM

class ViewController: VMViewController {
    lazy var viewModel: BasicViewModel = { return ViewModelCache.shared.viewModel() }()

    override func setupObservers() {
        viewModel.temp.observe { string in
            print(string)
        }

        viewModel.load()
    }
}

