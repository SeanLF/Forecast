# forecast.io menu bar app

## About
I've always wanted to make an OS X application, and learn the Swift programming
language. This is my first attempt at making a menu bar application. The goal of
this app is to quickly allow users to check the weather from the OS X
menu bar, provided by _[Forecast.io](https://forecast.io)_.

Thank you, [@brimelow](https://github.com/brimelow) for your [tutorial](http://www.swiftvideotutorials.com/creating-menubar-apps-osx)
on creating menubar apps in Swift for OS X!

## App permissions
The application requires Location Services to be turned on. This is to determine
the latitude and longitude to send to the Forecast API to get your local
weather forecast.

---
### Getting set up
You need a Dark Sky Forecast API key. If you do not have one, you can
register on [their website](https://developer.forecast.io). They allow 1K free
API calls per day.

##### Project Dependencies:   
- [CoreLocation](https://developer.apple.com/library/mac/documentation/CoreLocation/Reference/CoreLocation_Framework/index.html#//apple_ref/doc/uid/TP40007123)
- [ForecastIO](https://github.com/sxg/ForecastIO)

##### Development Dependencies
- [Xcode](https://developer.apple.com/xcode/)
- [CocoaPods](https://cocoapods.org)
  - As a [Ruby](https://www.ruby-lang.org/en/) [gem](https://rubygems.org)  
    1. Install a ruby version manager ([rvm](https://rvm.io) or
    [rbenv](https://github.com/rbenv/rbenv)).
    2. `gem install cocoapods --pre` install the latest
     [cocoapods](https://rubygems.org/gems/cocoapods/) gem
    3. `pod install` install the Pods listed in the Podfile
  - As an [OS X application](https://cocoapods.org/app)  
    ??? similar ???
