# SDWebViewImageCache

[![CI Status](http://img.shields.io/travis/jiehu5114/SDWebViewImageCache.svg?style=flat)](https://travis-ci.org/jiehu5114/SDWebViewImageCache)
[![Version](https://img.shields.io/cocoapods/v/SDWebViewImageCache.svg?style=flat)](http://cocoapods.org/pods/SDWebViewImageCache)
[![License](https://img.shields.io/cocoapods/l/SDWebViewImageCache.svg?style=flat)](http://cocoapods.org/pods/SDWebViewImageCache)
[![Platform](https://img.shields.io/cocoapods/p/SDWebViewImageCache.svg?style=flat)](http://cocoapods.org/pods/SDWebViewImageCache)

SDWebViewImageCache is used to share image resourece in native SDImageCache with UIWebView, which is based on SDWebImage.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* SDWebImage
* UIWebview


## Installation

SDWebViewImageCache is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDWebViewImageCache'
```


## Usage

Register the SDWebViewImageCache, when app launch.

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSURLProtocol registerClass:[SDWebViewCacheProtocol class]];
    return YES;
}
```

## Demo

For the same Image in iamgeview and webview, just download one time.




## License

SDWebViewImageCache is available under the MIT license. See the LICENSE file for more info.
