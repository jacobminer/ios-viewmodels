//
//  ViewController.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import UIKit
import MVVM

class ViewController: VMViewController<BasicViewModel> {
    @IBOutlet weak var label: UILabel!

    override func setupObservers() {
        viewModel.observe(viewModel.temp, ObserverData { string in
            self.label.text = string
        })
//        viewModel.temp.observe(viewModel, )

        viewModel.load()
    }

    @IBAction func counter(_ sender: Any) {
        viewModel.add()
    }
}

