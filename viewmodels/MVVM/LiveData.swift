//
//  LiveData.swift
//  viewmodels
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

internal protocol ObservableData {
    var _value: Any? { get set }
    func setIndex(_ index: Int)
    func getIndex() -> Int
    func removeObserver()
    func rePostValue()
}
