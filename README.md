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

### 如何引入 RN Modules 及加入 Activity

* [Integrating React Native into an Existing App (Android)](https://codeburst.io/integrating-react-native-into-an-existing-app-android-c27bb1b81574)可以學習到

* RN Component initial Props: [ReactMainActivity](https://github.com/duncan60/RN-integration-with-existing-app/blob/master/android/app/src/main/java/com/example/duncan_du/android/ReactMainActivity.java#L28-L39)

### Android & RN 溝通與事件增聽

* 建立繼承 ReactContextBaseJavaModule 的 class，並加入方法:

```
# /android/app/src/main/java/com/example/duncan_du/android/
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

## Others

* [20 分钟理解 React Native For Android 原理](https://juejin.im/entry/58d4770544d9040069295eaa)

* [ReactNativeAndroid 源码分析-Js 如何调用 Native 的代码](https://zhuanlan.zhihu.com/p/20464825)
