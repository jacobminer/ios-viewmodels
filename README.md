## Install the Pod ##

Add the following to your `Podfile`
`pod 'MVVMBuildItDay'`

Then run `pod install`.


## Usage ##

In your `AppDelegate.swift` add the following 

```swift
import MVVMBuildItDay
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ...
        MVVM.shared.initialize()
        return true
    }
    // ...
}
```

Create a subclass of ViewModel
```swift
import MVVMBuildItDay 

class BasicViewModel: ViewModel {
    // we'll come back to this later
}
```

In your UIViewController add the following
```swift
import MVVMBuildItDay

class ViewController: UIViewController {
    private let basicViewModel = BasicViewModel() // replace with your new ViewModel subclass
}

extension ViewController: LiveDataObserver  {
    func setupObservers() {
        
    }

    var viewModel: ViewModel {
        get {
            return basicViewModel // return your viewModel here
        }
    }
}
```

## Observing Data ##

In order to observe data, you must have data to observe, so add some liveData to your view model

```swift
import MVVMBuildItDay 

class BasicViewModel: ViewModel {
    lazy var simpleNumber = LiveData<Int>(self)
}
```

Next you must call `observe` on the live data, used in the `LiveDataObserver.setupObservers` function we added to our view controller earlier.

```swift 
func setupObservers() {
    basicViewModel.simpleNumber.observe { number in
        // data comes back as an optional
        guard let number = number else { return }
        print("\(number)")
    }
}
```

Your view controller will now automatically print the number when it changes.


## Monitoring Lifecycle Changes ##

ViewModel has a number of methods called when lifecycle changes occur on the view controller. You can override these for additional behaviour:

```swift 
class BasicViewModel: ViewModel {
    override func created() {
        // called when the view model is initially created. Good for loading data
    }

    override func backgrounded() {
        // called when the app is backgrounded
    }

    override func foregrounded() {
        // called when the app is foregrounded
    }

    override func onCleared() {
        // called when the view model has been cleared (due to viewcontroller de-init)
    }
}
```

