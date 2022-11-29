# NSLayoutKid

[![CI Status](https://img.shields.io/travis/sasawat.sankosik@gmail.com/NSLayoutKid.svg?style=flat)](https://travis-ci.org/sasawat.sankosik@gmail.com/NSLayoutKid)
[![Version](https://img.shields.io/cocoapods/v/NSLayoutKid.svg?style=flat)](https://cocoapods.org/pods/NSLayoutKid)
[![License](https://img.shields.io/cocoapods/l/NSLayoutKid.svg?style=flat)](https://cocoapods.org/pods/NSLayoutKid)
[![Platform](https://img.shields.io/cocoapods/p/NSLayoutKid.svg?style=flat)](https://cocoapods.org/pods/NSLayoutKid)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NSLayoutKid is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NSLayoutKid'
```

## Author

Sasawat Sankosik, sasawat.sankosik@gmail.com

## License

NSLayoutKid is available under the MIT license. See the LICENSE file for more info.

## Usage

**Setup Views**     
```swift
class MyViewController: UIViewController {
  let mainView = UIView()
  let mainButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}
```

**Setup Main View**  
```swift
view.addSubview(mainView)
mainView.anchor(axis: .top, to: view.safeAreaLayoutGuide)
mainView.anchorToSuperView(axes: .bottom)
```

**Setup Main Mutton**  
```swift
mainView.addSubview(mainButton)
mainButton.anchor(dimension: .height, constant: 50)
mainButton.anchorToSuperView(axes: .bottom, insets: .init(x: 16, y: 40))
```

## Axis Anchor
**Anchor**  
```swift
view.anchor(axis: .top)
view.anchor(axes: .top)
view.anchorToSuperView(axis: .top)
view.anchorToSuperView(axes: .top)
```

**Update Anchor**  
```swift
view.updateAnchor(axis: .top)
view.updateAnchor(axes: .top)
view.updateAnchorToSuperView(axis: .top)
view.updateAnchorToSuperView(axes: .top)
```

**Remove Anchor**  
```swift
view.removeAnchor(axis: .top)
view.removeAnchor(axes: .top)
view.removeAnchorToSuperView(axis: .top)
view.removeAnchorToSuperView(axes: .top)
```

## Dimension
**Dimension**  
```swift
view.anchor(dimension: .height, toItem: superview)
view.anchorDimensions(toItem: superview)
view.anchorToSuperView(dimension: .height)
view.anchorToSuperViewDimensions()
```

**Update Dimension**  
```swift
view.updateAnchor(dimension: .height, toItem: superview)
view.updateAnchorDimensions(toItem: superview)
view.updateAnchorToSuperView(dimension: .height)
view.updateAnchorToSuperViewDimensions()
```

**Remove Dimension**  
```swift
view.removeAnchor(dimension: .height, toItem: superview)
view.removeAnchorDimensions(toItem: superview)
view.removeAnchorToSuperView(dimension: .height)
view.removeAnchorToSuperViewDimensions()
```
