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

    public required init() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.backgrounded), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.foregrounded), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    open func created() {
        // override this to handle initial creation behaviour
    }

    @objc open func foregrounded() {
        // override this to handle app foregrounded behaviour
    }

    @objc open func backgrounded() {
        // override this to handle app backgrounded behaviour
    }

    open func onCleared() {
        // override this to handle additional clearing behaviour
    }

    func clearObservers() {
        onCleared()
        observedLiveData.forEach { $0.removeObserver() }
    }

    deinit {
        clearObservers()
        NotificationCenter.default.removeObserver(self)
    }

    func addLiveData(_ liveData: ObservableData) {
        liveData.setIndex(observedLiveData.count)
        observedLiveData.append(liveData)
    }

    func removeLiveData(_ liveData: ObservableData) {
        observedLiveData.removeAll { $0.getIndex() == liveData.getIndex() }
    }

    func postViewModelValues() {
        observedLiveData.forEach { liveData in
            liveData.rePostValue()
        }
    }
}
