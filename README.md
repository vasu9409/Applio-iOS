This library provides an daily uses functions For convenience, we added categories for UI elements like `UIView`.

## Features

- [x] UIView CornerRadius, BoderColor, BolderWidth, Shadow  set via UIStoryboard or Xib files.
- [x] Set UIView Gradient Color via UIStoryboard or Xib files.
- [x] Performances!

## Requirements
- iOS 10.0 or later
- tvOS 10.0 or later
- watchOS 2.0 or later
- Xcode 11.0 or later

## How To Use

* Register TableViewCell
```swift
import Applio

self.tableView.registerNib(for: "UITableViewCell")
```
* Register CollectionViewCell
```swift
import Applio

self.collectionView.registerNib(for: "UICollectionViewCell")
```

* Set UIView Corner Radius
```swift
import Applio

self.yourView.cornerRadius = 10
```

* Set UIView Border
```swift
import Applio

self.yourView.borderWidth = 1
self.yourView.borderColor = .white
```

## Installation

### Installation with CocoaPods
[CocoaPods](http://cocoapods.org/) is a dependency manager for Swift, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
platform :ios, '9.0'
pod 'Applio'
```

##### Swift and static framework

Swift project previously had to use `use_frameworks!` to make all Pods into dynamic framework to let CocoaPods work.

However, starting with `CocoaPods 1.5.0+` (with `Xcode 9+`), which supports to build both Objective-C && Swift code into static framework. You can use modular headers to use SDWebImage as static framework, without the need of `use_frameworks!`:

```
platform :ios, '9.0'
# Uncomment the next line when you want all Pods as static framework
# use_modular_headers!
pod 'Applio'
```

See more on [CocoaPods 1.5.0 — Swift Static Libraries](http://blog.cocoapods.org/CocoaPods-1.5.0/)

If not, you still need to add `use_frameworks!` to use SDWebImage as dynamic framework:

```
platform :ios, '9.0'
use_frameworks!
pod 'Applio'
```

### Build Project

At this point your workspace should build without error. If you are having problem, post to the Issue and the
community can help you solve it.

## Author
- [Vasu Savaliya](https://github.com/vasu9409)

## Credits

Thank you to all the people who have already contributed to Applio.
