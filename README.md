# ShatteringView




## Demo
[![Demo ShatteringView alpha]()](http://share.gifyoutube.com/yXO4L8.gif)


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To animate the view
```
 [self.viewToSplash smashIt:YES onCompletion:^(BOOL finished) {
        self.viewToSplash.hidden = NO;
    }];
```

## Installation

ShatteringView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ShatteringView"
```

## Author

Stas Batururimi, blueocean87@me.com

## License

ShatteringView is available under the MIT license. See the LICENSE file for more info.
