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
        print("ViewController: viewDidLoad")
        postViewModelValues()
        print("ViewController: Setting up observers")
        setupObservers()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController: viewWillAppear")
        postViewModelValues()
    }

    private func postViewModelValues() {
        print("ViewController: Posting values")
        viewModels.forEach { $0.postViewModelValues() }
    }

    deinit {
        print("ViewController: deinit, calling clear observers on viewModels")
        viewModels.forEach { $0.clearObservers() }
    }
}
