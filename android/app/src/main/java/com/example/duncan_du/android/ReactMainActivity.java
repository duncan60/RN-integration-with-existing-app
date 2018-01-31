package com.example.duncan_du.android;

import com.facebook.react.ReactActivity;

/**
 * Created by duncan_du on 2018/1/29.
 */

import android.support.annotation.Nullable;
import android.os.Bundle;
import android.app.Activity;

import com.facebook.react.ReactActivityDelegate;
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler;
import com.facebook.react.ReactRootView;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.react.common.LifecycleState;



public class ReactMainActivity extends ReactActivity {
    @Override
    protected String getMainComponentName() {
        return "RNExistingApp";
    }

    @Override
    protected ReactActivityDelegate createReactActivityDelegate() {
        return new ReactActivityDelegate(this, getMainComponentName()) {
            @Nullable
            @Override
            protected Bundle getLaunchOptions() {
                Bundle initialProps = new Bundle();
                initialProps.putString("message", "Hello, I'm come from Android");
                return initialProps;
            }
        };
    }

}