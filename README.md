# Flicks

A photos catalog app using the [Unsplash API](https://unsplash.com/documentation#creating-a-developer-account).

## Requirements

 - iOS 13+
 - Xcode 11.3+ (Swift 5.1)

## Getting Started

1. Install [Carthage](https://github.com/Carthage/Carthage) (v0.34 or greater) and run `carthage update --platform iOS`.
2. Open the `Flicks.xcodeproj` file.

## Test Suite

Run tests using `xcodebuild`:

```
xcodebuild clean test -project Flicks.xcodeproj -scheme Flicks -destination "platform=iOS Simulator,OS=13.3,name=iPhone 11" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO
```

Expected output:

```
2020-01-24 09:03:33.036986+0000 Flicks[72365:2858872] Waiting to run tests until the app finishes launching.
Test Suite 'All tests' started at 2020-01-24 09:03:33.345
Test Suite 'FlicksTests.xctest' started at 2020-01-24 09:03:33.346
Test Suite 'FlicksTests' started at 2020-01-24 09:03:33.347
Test Case '-[FlicksTests.FlicksTests testPhotoCatalogDataProvider]' started.
Test Case '-[FlicksTests.FlicksTests testPhotoCatalogDataProvider]' passed (0.002 seconds).
Test Suite 'FlicksTests' passed at 2020-01-24 09:03:33.350.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.002 (0.003) seconds
Test Suite 'FlicksTests.xctest' passed at 2020-01-24 09:03:33.352.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.002 (0.006) seconds
Test Suite 'All tests' passed at 2020-01-24 09:03:33.353.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.002 (0.007) seconds
2020-01-24 09:03:33.648 xcodebuild[72246:2857468] [MT] IDETestOperationsObserverDebug: 4.295 elapsed -- Testing started completed.
2020-01-24 09:03:33.648 xcodebuild[72246:2857468] [MT] IDETestOperationsObserverDebug: 0.000 sec, +0.000 sec -- start
2020-01-24 09:03:33.648 xcodebuild[72246:2857468] [MT] IDETestOperationsObserverDebug: 4.295 sec, +4.295 sec -- end

Test session results, code coverage, and logs:
	/Volumes/Extra/Library/Xcode/DerivedData/Flicks-bovmdctyegsfnieagxoouneiqend/Logs/Test/Run-Flicks-2020.01.24_09-03-12-+0000.xcresult

** TEST SUCCEEDED **
```
