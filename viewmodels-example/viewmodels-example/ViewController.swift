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
    @IBOutlet weak var label: UILabel!

    override var viewModel: ViewModel {
        return basicViewModel
    }
    private let basicViewModel = BasicViewModel()

    override func setupObservers() {
        basicViewModel.temp.observe { string in
            self.label.text = string
        }

        basicViewModel.load()
    }

    @IBAction func counter(_ sender: Any) {
        basicViewModel.add()
    }
}

