//
//  LiveDataObserver.swift
//  MVVM
//
//  Created by Jake on 2018-11-15.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

public protocol LiveDataObserver {
    func setupObservers()
    var viewModel: ViewModel { get }
}
