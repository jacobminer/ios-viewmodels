//
//  LiveData.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

// Observable data implementation
public class LiveData<T: Any>: ObservableData {
    public typealias Observer = (T?) -> Void

    // need to keep a reference to viewmodel
    private var viewModel: ViewModel

    var _value: Any? {
        get {
            return value
        }
        set {
            value = newValue as? T
        }
    }

    var observer: Observer? {
        didSet {
            // if we have a value when this is set, fire the value
            if let value = value {
                observer?(value)
            }
        }
    }

    // notify observer when value changes
    public var value: T? {
        didSet {
            notifyObserver()
        }
    }

    // initialize with a view model and an optional initial value
    public init(_ viewModel: ViewModel, initialValue: T? = nil) {
        self.viewModel = viewModel
        self.value = initialValue
    }

    // add observer to this data, must occur on main thread
    public func observe(observer: @escaping Observer) {
        assert(Thread.isMainThread, "Only add observer from the main thread.")
        self.observer = observer
        viewModel.addLiveData(self)
    }

    public func removeObserver() {
        assert(Thread.isMainThread, "Only remove observer from the main thread.")
        self.observer = nil
    }

    // forces the value to be updated on the main thread
    public func postValue(_ value: T?) {
        DispatchQueue.main.async {
            self.value = value
        }
    }

    private func notifyObserver() {
        assert(Thread.isMainThread, "Value must only be set on main thread. To set value from background thread, use postValue")
        // notify observer that this was set
        observer?(value)

    }

    func rePostValue() {
        observer?(value)
    }
}
