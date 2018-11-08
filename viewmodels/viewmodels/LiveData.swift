//
//  LiveData.swift
//  viewmodels
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

public class LiveData<T> {
    public typealias Observer = ((T?) -> Void)

    private var observer: Observer? {
        didSet {
            guard let observer = observer else {
                return
            }

            // if we have a value when this is set, fire the value
            if let value = value {
                observer(value)
            }
        }
    }

    var value: T? {
        didSet {
            guard let observer = observer else {
                return
            }

            // notify observers that this was set
            observer(value)
        }
    }

    public init(initialValue: T? = nil) {
        self.value = initialValue
    }

    public func observe(_ observer: @escaping Observer) {
        self.observer = observer

    }
}
