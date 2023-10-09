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
mainView.nslk.anchor(axis: .top, to: view.safeAreaLayoutGuide)
mainView.nslk.anchorToSuperView(axes: .bottom)
```

**Setup Main Mutton**  
```swift
mainView.addSubview(mainButton)
mainButton.nslk.anchor(dimension: .height, constant: 50)
mainButton.nslk.anchorToSuperView(axes: .bottom, insets: .init(x: 16, y: 40))
```

## Axis Anchor
**Anchor**  
```swift
view.nslk.anchor(axis: .top)
view.nslk.anchor(axes: .top)
view.nslk.anchorToSuperView(axis: .top)
view.nslk.anchorToSuperView(axes: .top)
```

**Update Anchor**  
```swift
view.nslk.updateAnchor(axis: .top)
view.nslk.updateAnchor(axes: .top)
view.nslk.updateAnchorToSuperView(axis: .top)
view.nslk.updateAnchorToSuperView(axes: .top)
```

**Remove Anchor**  
```swift
view.nslk.removeAnchor(axis: .top)
view.nslk.removeAnchor(axes: .top)
view.nslk.removeAnchorToSuperView(axis: .top)
view.nslk.removeAnchorToSuperView(axes: .top)
```

## Dimension
**Dimension**  
```swift
view.nslk.anchor(dimension: .height, toItem: superview)
view.nslk.anchorDimensions(toItem: superview)
view.nslk.anchorToSuperView(dimension: .height)
view.nslk.anchorToSuperViewDimensions()
```

**Update Dimension**  
```swift
view.nslk.updateAnchor(dimension: .height, toItem: superview)
view.nslk.updateAnchorDimensions(toItem: superview)
view.nslk.updateAnchorToSuperView(dimension: .height)
view.nslk.updateAnchorToSuperViewDimensions()
```

**Remove Dimension**  
```swift
view.nslk.removeAnchor(dimension: .height, toItem: superview)
view.nslk.removeAnchorDimensions(toItem: superview)
view.nslk.removeAnchorToSuperView(dimension: .height)
view.nslk.removeAnchorToSuperViewDimensions()
```
