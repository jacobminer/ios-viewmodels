//
//  UIViewController+ViewModels.swift
//  MVVM
//
//  Created by Jake on 2018-11-15.
//  Copyright © 2018 Steamclock Software. All rights reserved.
//

import Foundation


// Class for handling deallocation of objects without swizzling deinit
final class Deallocator {
    var closure: () -> Void

    init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    deinit {
        closure()
    }
}

// function for performing the swizzling
let swizzling: (UIViewController.Type) -> () = { viewController in
    func swizzleMethod(originalSelector: Selector, newSelector: Selector) {
        let originalMethod = class_getInstanceMethod(viewController, originalSelector)
        let swizzledMethod = class_getInstanceMethod(viewController, newSelector)

        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }

    // swizzle viewDidLoad
    swizzleMethod(originalSelector: #selector(viewController.viewDidLoad),
                  newSelector: #selector(viewController.swiz_viewDidLoad))

    // swizzle viewWillAppear
    swizzleMethod(originalSelector: #selector(viewController.viewWillAppear(_:)),
                   newSelector: #selector(viewController.swiz_viewWillAppear(animated:)))

    // swizzle viewWillDisappear
    swizzleMethod(originalSelector: #selector(viewController.viewWillDisappear(_:)),
                   newSelector: #selector(viewController.swiz_viewWillDisappear(animated:)))
}

private var associatedObjectAddr = ""

extension UIViewController {
    // swizzled version of viewDidLoad
    // Adds a deallocator to the view controller and clears observers when deallocated
    @objc func swiz_viewDidLoad() {
        self.swiz_viewDidLoad()
        let deallocator = Deallocator {
            print("ViewController: Deallocating")
            (self as? LiveDataObserver)?.viewModel.clearObservers()
        }
        
        objc_setAssociatedObject(self, &associatedObjectAddr, deallocator, .OBJC_ASSOCIATION_RETAIN)
    }

    // swizzled version of viewWillAppear
    // sets up observers when view appears and posts current values
    @objc func swiz_viewWillAppear(animated: Bool) {
        self.swiz_viewWillAppear(animated: animated)
        print("ViewController: viewWillAppear")
        print("ViewController: Setting up observers")
        (self as? LiveDataObserver)?.setupObservers()
        print("ViewController: Posting view model values")
        (self as? LiveDataObserver)?.viewModel.postViewModelValues()
    }

    // swizzled version of viewWillDisappear
    // clears observers when view disappears
    @objc func swiz_viewWillDisappear(animated: Bool) {
        self.swiz_viewWillDisappear(animated: animated)
        print("ViewController: view disappearing, calling clear observers on viewModels")
        (self as? LiveDataObserver)?.viewModel.clearObservers()
    }
}
