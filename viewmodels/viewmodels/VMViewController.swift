//
//  VMViewController.swift
//  viewmodels
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

open class VMViewController: UIViewController {
    private var observedLiveData = [LiveData]()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        postViewModelValues()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postViewModelValues()

    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func addLiveData(_ liveData: LiveData) {
        liveData.setIndex(observedLiveData.count)
        observedLiveData.append(liveData)
    }

    func removeLiveData(_ liveData: LiveData) {
        observedLiveData.removeAll { $0.getIndex() == liveData.getIndex() }
    }

    private func postViewModelValues() {
        observedLiveData.forEach { liveData in
            liveData.rePostValue()
        }
    }

    deinit {
        observedLiveData.forEach {
            $0.removeObserver(owner: self)
        }
    }
}
