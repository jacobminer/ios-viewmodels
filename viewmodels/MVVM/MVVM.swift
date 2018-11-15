//
//  MVVM.swift
//  MVVM
//
//  Created by Jake on 2018-11-15.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

// used to setup the swizzling
public class MVVM {
    public static let shared = MVVM()

    private init() {
        // enforce singleton
    }

    public func initialize() {
        swizzling(UIViewController.self)
    }
}

