//
//  BasicViewModel.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation
import MVVM

class BasicViewModel: ViewModel {
    lazy var temp = LiveData<String>(self)

    var counter = 0 {
        didSet {
            temp.value = "\(counter)"
        }
    }

    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.temp.value = "Hello world"
        }
    }

    override func created() {
        counter = 20
    }

    override func backgrounded() {
        self.temp.value = "Backgrounded"
    }

    override func foregrounded() {
        self.temp.value = "Foregrounded"
    }

    override func onCleared() {
//        self.temp.value = "Cleared"
    }

    func add() {
        counter += 1
    }
}
