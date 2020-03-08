package com.rjx.asr_plugin;

import android.util.Log;

import io.flutter.plugin.common.MethodChannel;

public class ResultStateful implements MethodChannel.Result {
    private static final String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called;

    public ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    @Override
    public void success(Object o) {
        if (called) {
            Log.e(TAG, "Has called before");
            return;
        }
        called = true;
        this.result.success(o);


    }

    @Override
    public void error(String errorCode, String errorMessage, Object errorDetails) {
        if (called) {
            Log.e(TAG, "Has called error before");
            return;
        }
        called = true;
        this.result.error(errorCode,errorMessage,errorDetails);
    }

    @Override
    public void notImplemented() {
        if (called) {
            Log.e(TAG, "Has called not Implemented");
            return;
        }
        called = true;
        this.result.notImplemented();
    }
}
