package com.example.duncan_du.android;

import com.facebook.react.bridge.ReactContextBaseJavaModule;

import android.widget.Toast;
import android.support.annotation.Nullable;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import java.util.Map;
import java.util.HashMap;

/**
 * Created by duncan_du on 2018/1/30.
 */

public class ReactEventManager extends ReactContextBaseJavaModule {

    public ReactEventManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ReactEventManager";
    }

    @ReactMethod
    public void showNativeAlert(String message) {
        Toast.makeText(getReactApplicationContext(), message, Toast.LENGTH_LONG).show();
        this.getReactApplicationContext()
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit("eventToRN","test RN integration with existing app");
    }
}
