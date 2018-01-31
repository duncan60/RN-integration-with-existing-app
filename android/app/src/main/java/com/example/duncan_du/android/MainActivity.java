package com.example.duncan_du.android;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.content.Intent;
import android.util.Log;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    public void onAddRNClick(View view) {
        // Set up the intent
        Intent i = new Intent(getApplicationContext(), ReactMainActivity.class);
        Log.d("ReactNative", "MainActivity onAddRNClick");
        // Launch It
        startActivity(i);
    }
}
