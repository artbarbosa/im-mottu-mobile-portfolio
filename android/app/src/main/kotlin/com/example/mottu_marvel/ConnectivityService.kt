package com.mottu.marvel

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.NetworkInfo
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class ConnectivityService : FlutterPlugin, BroadcastReceiver() {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "connectivity_channel")
        val filter = IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
        binding.applicationContext.registerReceiver(this, filter)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.applicationContext.unregisterReceiver(this)
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == ConnectivityManager.CONNECTIVITY_ACTION) {
            val connectivityManager = context?.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork: NetworkInfo? = connectivityManager.activeNetworkInfo
            val isConnected = activeNetwork?.isConnectedOrConnecting == true
            channel.invokeMethod("updateConnectionStatus", isConnected)
        }
    }
}
