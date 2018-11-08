//
//  ViewController.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import UIKit
import viewmodels

class ViewController: VMViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let temp = MutableLiveData<String>()

        temp.observe(owner: self) { string in
            print(string)
        }

        temp.value = "Hello world"

        // Do any additional setup after loading the view, typically from a nib.
    }


}

