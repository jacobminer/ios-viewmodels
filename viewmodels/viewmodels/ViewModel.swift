//
//  ViewModel.swift
//  viewmodels
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

open class ViewModel {
    var observedLiveData = [ObservableData]()

    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.backgrounded), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewModel.foregrounded), name: UIApplication.didBecomeActiveNotification, object: nil)
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

    deinit {
        onCleared()
        observedLiveData.forEach { $0.removeObserver() }
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
