//
//  MutableLiveData.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

public protocol Observer: class {
    associatedtype T
    func updated(value: T?)
}

public class ObserverData<U: Any>: Observer {
    public typealias T = U
    private let update: ((U?) -> Void)
    public func updated(value: U?) {
        update(value)
    }

    public init(update: @escaping ((U?) -> Void)) {
        self.update = update
    }
}

public class OptionalLiveData<T: Any>: ObservableData {
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

    private weak var observer: ObserverData<T>? {
        didSet {
            guard let observer = observer else {
                return
            }

            // if we have a value when this is set, fire the value
            if let value = value {
                observer.updated(value: value)
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

    public func observe(_ observer: ObserverData<T>) {
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
        observer.updated(value: value)

    }

    func rePostValue() {
        observer?.updated(value: value)
    }
}
