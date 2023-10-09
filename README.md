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
mainView.lkd.anchor(axis: .top, to: view.safeAreaLayoutGuide)
mainView.lkd.anchorToSuperView(axes: .bottom)
```

**Setup Main Mutton**  
```swift
mainView.addSubview(mainButton)
mainButton.lkd.anchor(dimension: .height, constant: 50)
mainButton.lkd.anchorToSuperView(axes: .bottom, insets: .init(x: 16, y: 40))
```

## Axis Anchor
**Anchor**  
```swift
view.lkd.anchor(axis: .top)
view.lkd.anchor(axes: .top)
view.lkd.anchorToSuperView(axis: .top)
view.lkd.anchorToSuperView(axes: .top)
```

**Update Anchor**  
```swift
view.lkd.updateAnchor(axis: .top)
view.lkd.updateAnchor(axes: .top)
view.lkd.updateAnchorToSuperView(axis: .top)
view.lkd.updateAnchorToSuperView(axes: .top)
```

**Remove Anchor**  
```swift
view.lkd.removeAnchor(axis: .top)
view.lkd.removeAnchor(axes: .top)
view.lkd.removeAnchorToSuperView(axis: .top)
view.lkd.removeAnchorToSuperView(axes: .top)
```

## Dimension
**Dimension**  
```swift
view.lkd.anchor(dimension: .height, toItem: superview)
view.lkd.anchorDimensions(toItem: superview)
view.lkd.anchorToSuperView(dimension: .height)
view.lkd.anchorToSuperViewDimensions()
```

**Update Dimension**  
```swift
view.lkd.updateAnchor(dimension: .height, toItem: superview)
view.lkd.updateAnchorDimensions(toItem: superview)
view.lkd.updateAnchorToSuperView(dimension: .height)
view.lkd.updateAnchorToSuperViewDimensions()
```

**Remove Dimension**  
```swift
view.lkd.removeAnchor(dimension: .height, toItem: superview)
view.lkd.removeAnchorDimensions(toItem: superview)
view.lkd.removeAnchorToSuperView(dimension: .height)
view.lkd.removeAnchorToSuperViewDimensions()
```
