//
//  MutableLiveData.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

public class OptionalLiveData<T: Any>: ObservableData {
    public typealias Observer = (T?) -> Void

    private var parent: ViewModel
    var index: Int!

    func getIndex() -> Int {
        return index
    }

    func setIndex(_ index: Int) {
        self.index = index
    }

    var _value: Any? {
        get {
            return value
        }
        set {
            value = newValue as? T
        }
    }

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

    public var value: T? {
        didSet {
            notifyObserver()
        }
    }

    public init(parent viewModel: ViewModel, initialValue: T? = nil) {
        self.parent = viewModel
        self.value = initialValue
    }

    public func observe(_ observer: @escaping Observer) {
        assert(Thread.isMainThread, "Only add observers from the main thread.")
        self.observer = observer
        parent.addLiveData(self)
    }

    public func removeObserver() {
        self.observer = nil
        parent.removeLiveData(self)
    }

    public func postValue(_ value: T?) {
        DispatchQueue.main.async {
            self.value = value
        }
    }

    private func notifyObserver() {
        assert(Thread.isMainThread, "Value must only be set on main thread. To set value from background thread, use postValue")

        guard let observer = observer else {
            return
        }

        // notify observers that this was set
        observer(value)

    }

    func rePostValue() {
        observer?(value)
    }
}
