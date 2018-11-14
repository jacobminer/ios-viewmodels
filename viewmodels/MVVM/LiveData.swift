//
//  LiveData.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

internal protocol ObservableData {
    var _value: Any? { get set }
    func removeObserver()
    func rePostValue()
}
