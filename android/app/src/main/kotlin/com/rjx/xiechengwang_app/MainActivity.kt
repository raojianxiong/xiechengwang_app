package com.rjx.xiechengwang_app

import android.os.Bundle
import com.rjx.asr_plugin.AsrPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        SplashScreen.show(this,true)
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerSelfPlugin()
    }

    private fun registerSelfPlugin() {
        AsrPlugin.registerWith(registrarFor("com.rjx.asr_plugin.AsrPlugin"))
    }
}
