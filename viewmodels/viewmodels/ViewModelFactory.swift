//
//  ViewModelFactory.swift
//  viewmodels
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

    public func viewModel<T: ViewModel>(from object: AnyObject) -> T {
        let objectName = String(describing: object)
        if (viewModels[objectName] == nil) {
            viewModels[objectName] = T()
        }
        return viewModels[objectName] as! T
    }
}
