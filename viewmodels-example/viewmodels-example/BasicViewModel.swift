//
//  BasicViewModel.swift
//  viewmodels-example
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation
import viewmodels

class BasicViewModel: ViewModel {
    lazy var temp = OptionalLiveData<String>(parent: self)

    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.temp.value = "Hello world"
        }
    }

    override func backgrounded() {
        self.temp.value = "Backgrounded"
    }

    override func foregrounded() {
        self.temp.value = "Foregrounded"
    }

    override func onCleared() {
        self.temp.value = "Cleared"
    }
}
