//
//  ViewModelFactory.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

public class ViewModelCache {
    public static let shared = ViewModelCache()

    private var viewModels = [String: ViewModel]()

    private init() {
        // enforce singleton status
    }

    public func viewModel<T: ViewModel>(afterCreated: ((T) -> Void)? = nil) -> T {
        let objectName = String(describing: T.self)
        if (viewModels[objectName] == nil) {
            let viewModel = T.init()
            viewModels[objectName] = viewModel
            afterCreated?(viewModel)
            viewModel.created()
            return viewModel
        } else {
            return viewModels[objectName] as! T
        }
    }
}
