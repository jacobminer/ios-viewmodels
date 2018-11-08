//
//  VMTableViewController.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

open class VMTableViewController: UITableViewController {
    private var viewModels = [ViewModel]()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func setupObservers() {
        precondition(false, "Override setupObservers")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        postViewModelValues()
        setupObservers()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postViewModelValues()
    }

    private func postViewModelValues() {
        viewModels.forEach { $0.postViewModelValues() }
    }

    deinit {
        viewModels.forEach { $0.onCleared() }
    }
}
