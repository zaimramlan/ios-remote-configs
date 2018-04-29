# Remote Configs

[![IDE](https://img.shields.io/badge/Xcode-9-blue.svg)](https://developer.apple.com/xcode/)
[![Platform](https://img.shields.io/badge/platform-iOS%2011-green.svg)](https://developer.apple.com/ios/)
[![Language](https://img.shields.io/badge/swift-4-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A question of the day iOS app to demonstrate realtime remote configuration changes in Firebase.

![Example](http://g.recordit.co/mzHDwdjMEL.gif)

## Features
1. Written in CleanSwift architecture
1. Validates realtime question and answer of the day 
1. A `RemoteConfigurationWorker.swift` that wraps `FirebaseRemoteConfig` singleton object and to decouple from app's code

## Protips/Pitfalls
1. Default values can be configured using `.plist` file
1. Configs fetched needs to be activated before it can be used. Otherwise it will fallback to default values specified
1. There are 2 functions to fetching remote configurations from Firebase:
    1. `fetch(completionHandler:)`
        - Caches values on first successful request
        - Caches invalidate itself after 12 hours
    1. `fetch(withExpirationDuration:completionHandler:)`
        - Invalidates caches when expiry duration exceeded and will fetch directly from Firebase RemoteConfig
        - Caching invalidation & direct fetching are limited to 5 times every 60 minutes per app
        - Afterwards, it will continue using cache until the next hour to prevent app from spamming calls to Firebase RemoteConfig
1. Caching and throttling happens in app's SDK
1. Workarounds to caching and throttling:
    1. Delete and reinstall app, or
    1. Switch `developerMode` to `true`:
        ```Swift
        let remoteConfig = RemoteConfig.remoteConfig()
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings
        ```
