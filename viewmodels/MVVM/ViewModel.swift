//
//  ViewModel.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

open class ViewModel {
    var observedLiveData = [ObservableData]()

    private var name: String {
        return String(describing: self)
    }

    public required init() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.backgrounded), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.foregrounded), name: UIApplication.didBecomeActiveNotification, object: nil)
        print("\(name) initialized")
    }

    open func created() {
        print("\(name): Created view model: \(String(describing: self))")
        // override this to handle initial creation behaviour
    }

    @objc open func foregrounded() {
        print("\(name): App foregrounded")
        // override this to handle app foregrounded behaviour
    }

    @objc open func backgrounded() {
        print("\(name): App backgrounded")
        // override this to handle app backgrounded behaviour
    }

    open func onCleared() {
        print("\(name): Calling onCleared")
        // override this to handle additional clearing behaviour
    }

    func clearObservers() {
        print("\(name): Beginning clear observers")
        print("\(name): Calling onCleared")
        onCleared()
        print("\(name): Removing all observers")
        observedLiveData.forEach { $0.removeObserver() }
        observedLiveData.forEach { removeLiveData($0) }
    }

    deinit {
        clearObservers()
        print("\(name): Removing notification center observers")
        NotificationCenter.default.removeObserver(self)
    }

    func addLiveData(_ liveData: ObservableData) {
        print("\(name): Adding live data \(String(describing: liveData)), now observing \(observedLiveData.count + 1) live data instances")
        liveData.setIndex(observedLiveData.count)
        observedLiveData.append(liveData)
    }

    func removeLiveData(_ liveData: ObservableData) {
        print("\(name): Removing live data \(String(describing: liveData))")
        observedLiveData.removeAll { $0.getIndex() == liveData.getIndex() }
    }

    func postViewModelValues() {
        print("\(name): Posting view model values")
        observedLiveData.forEach { liveData in
            liveData.rePostValue()
        }
    }
}
