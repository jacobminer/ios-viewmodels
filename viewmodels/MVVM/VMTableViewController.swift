//
//  VMTableViewController.swift
//  MVVM
//
//  Created by Jake on 2018-11-08.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation

open class VMTableViewController: UITableViewController {
    open var viewModel: ViewModel {
        return ViewModel()
    }

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

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController: viewWillAppear")
        print("ViewController: Setting up observers")
        setupObservers()
        print("ViewController: Posting view model values")
        viewModel.postViewModelValues()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController: view disappearing, calling clear observers on viewModels")
        viewModel.clearObservers()
    }

    deinit {
        print("ViewController: deinit, calling clear observers on viewModels")
        viewModel.clearObservers()
    }
}
