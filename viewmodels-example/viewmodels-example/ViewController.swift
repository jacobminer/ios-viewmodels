//
//  ViewController.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import UIKit
import MVVM

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    private let basicViewModel = BasicViewModel()

    @IBAction func counter(_ sender: Any) {
        basicViewModel.add()
    }
}

extension ViewController: LiveDataObserver  {
    func setupObservers() {
        basicViewModel.temp.observe { string in
            self.label.text = string
        }

        basicViewModel.load()
    }

    var viewModel: ViewModel {
        get {
            return basicViewModel
        }
    }
}
