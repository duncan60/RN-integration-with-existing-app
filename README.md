# RN-integration-with-existing-app

嘗試將 React Native 與現有 Native Android/iOS APP 做配合溝通的簡單範例。

## Build Setup

```
# install react-native dependencies, cd rn/
yarn

# run react-native
yarn run start


# open Android Studio, Run Android project
```

## Android 要點：

### 引入 RN Modules

* [android/build.gradle](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/build.gradle#L18-L30) 加入 react-native modules

* `android/settings.gradle` 選項是否加入 rootProject.name(這邊範例沒有加)

* [android/app/build.gradle]

  * [defaultConfig.ndk](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/app/build.gradle#L12-L14)

  * [dependencies](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/app/build.gradle#L28)

  * [task](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/app/build.gradle#L34-L37)

## Android 資源

* [Integrating React Native into an Existing App (Android)](https://codeburst.io/integrating-react-native-into-an-existing-app-android-c27bb1b81574)

* [20 分钟理解 React Native For Android 原理](https://juejin.im/entry/58d4770544d9040069295eaa)

* [ReactNativeAndroid 源码分析-Js 如何调用 Native 的代码](https://zhuanlan.zhihu.com/p/20464825)
