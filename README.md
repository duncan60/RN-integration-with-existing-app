# RN-integration-with-existing-app

嘗試將 React Native 與現有 Java/Objective-C Native APP 做配合溝通的簡單範例。

## Build Setup

```
# install react-native dependencies, cd rn/
yarn

# run react-native
yarn run start


# open Android Studio, Run Android project
```

## Android 要點：

### 如何引入 RN Modules 及加入 Activity

* [Integrating React Native into an Existing App (Android)](https://codeburst.io/integrating-react-native-into-an-existing-app-android-c27bb1b81574)可以學習到

* RN Component initial Props: [ReactMainActivity](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/app/src/main/java/com/example/duncan_du/android/ReactMainActivity.java#L28-L39)

### Android & RN 溝通與事件增聽

* 建立繼承 ReactContextBaseJavaModule 的 class，並加入方法:

```
# /android/app/src/main/java/com/example/duncan_du/android/ReactEventManager.java
public class ReactEventManager extends ReactContextBaseJavaModule {

    public ReactEventManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ReactEventManager";
    }

    @ReactMethod
    public void show(String message) {
        Toast.makeText(getReactApplicationContext(), message, Toast.LENGTH_LONG).show();
        // send event to RN
        this.getReactApplicationContext()
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("eventToRN","connecting RN.....");
    }
}
```

* 建立繼承 ReactPackage 的 class，並將剛建立的 ReactEventManager 加入:

```
# /android/app/src/main/java/com/example/duncan_du/android/AnExampleReactPackage.java
public class AnExampleReactPackage implements ReactPackage {

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }

    @Override
    public List<NativeModule> createNativeModules(
            ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();

        modules.add(new ReactEventManager(reactContext));

        return modules;
    }
}
```

* MainApplication 中加入 ReactPackage 的引用：

```
# /android/app/src/main/java/com/example/duncan_du/android/MainApplication.java
@Override
        protected List<ReactPackage> getPackages() {
            return Arrays.<ReactPackage>asList(
                    new MainReactPackage(),
                    new AnExampleReactPackage()
            );
        }
```

* 透過 React-Native NativeModules & NativeEventEmitter 和 Native 做溝通：

```
# rn/App.js

import {
  NativeModules,
  NativeEventEmitter,
} from 'react-native';
const { ReactEventManager } = NativeModules;

# onPress Method
ReactEventManager.show('From React Native: Awesome!');

# Event AddListener
componentDidMount() {
    const ManagerEvent = new NativeEventEmitter(ReactEventManager);
    this._subscription = ManagerEvent.addListener('eventToRN', (info) => {
      this.setState({ nativeEventInfo: info });
    });
  }
componentWillUnmount() {
  this._subscription.remove();
}
```

## iOS 要點

### 如何引入 RN Modules

* [React Native Tutorial: Integrating in an Existing App](https://www.raywenderlich.com/136047/react-native-existing-app)可以學習到

### 加入到 ViewController

```
# /ios/ios/ViewController.m

- (IBAction)addRNViewPressed:(id)sender {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];

    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                moduleName: @"RNExistingApp"
                            initialProperties:
        @{
        @"message" : @"Hello, I'm come from iOS"
        }
                                launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}
```

### iOS & RN 溝通與事件增聽

* 建立 .h & .m 檔案，加入發法與曾聽事件， RN Complete 與 Android 一樣，無需改動

```
# /ios/ios/ReactEventManager.h

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface ReactEventManager : RCTEventEmitter <RCTBridgeModule>

@end


# /ios/ios/ReactEventManager.m

#import "ReactEventManager.h"
#import <React/RCTLog.h>

@implementation ReactEventManager

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"eventToRN"];
}

RCT_EXPORT_METHOD(show:(NSString *)message)
{
    RCTLogInfo(@"from RN Message %@", message);

    [self sendEventWithName:@"eventToRN" body:@"test RN integration with existing app"];

    UIViewController *presentingController = RCTPresentedViewController();

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

    [alertController addAction:ok];

    [presentingController presentViewController:alertController animated:YES completion: nil];
}


@end
```

## 學習資源

### Android

* [20 分钟理解 React Native For Android 原理](https://juejin.im/entry/58d4770544d9040069295eaa)

* [ReactNativeAndroid 源码分析-Js 如何调用 Native 的代码](https://zhuanlan.zhihu.com/p/20464825)

### iOS

* [Integrating React Native into an Existing App (iOS)](https://codeburst.io/integrate-react-native-into-an-existing-app-ios-87c947a16044)

* [ReactNative iOS 源码解析](http://awhisper.github.io/2016/06/24/ReactNative%E6%B5%81%E7%A8%8B%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90/)

### 其他

* [[深入 REACTNATIVE]第一篇 通訊及消息迴圈代碼剖析](https://ddnews.me/tech/wdj0oxjh.html)
* [React Native 学习记录 － JS 和 OC 通信流程](http://tutudev.com/2016/04/26/React-Native-Study/)
