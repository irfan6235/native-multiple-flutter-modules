package com.example.androidapp

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

private const val SHOP_ENGINE = "shop_engine"
private const val PAYMENT_ENGINE = "payment_engine"
private const val PAYMENT_CHANNEL = "jodetx/payment"

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val flutterLoader = FlutterLoader()
        flutterLoader.startInitialization(applicationContext)
        flutterLoader.ensureInitializationComplete(applicationContext, null)
        val appBundlePath = flutterLoader.findAppBundlePath()

        val shopEngine = FlutterEngine(this)
        shopEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(appBundlePath, "shopMain")
        )
        FlutterEngineCache.getInstance().put(SHOP_ENGINE, shopEngine)

        val paymentEngine = FlutterEngine(this)
        paymentEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(appBundlePath, "paymentMain")
        )
        FlutterEngineCache.getInstance().put(PAYMENT_ENGINE, paymentEngine)

        // ✅ Handle callbacks from both Shop and Payment engines
        val channelHandler = MethodChannel.MethodCallHandler { call, result ->
            when (call.method) {
                "paymentResult" -> {
                    val status = call.argument<String>("status") ?: "Unknown"
                    val amount = call.argument<Double>("amount") ?: 0.0
                    runOnUiThread {
                        showDialog("Payment $status for ₹$amount")
                    }
                    result.success(null)
                }
                "closeFlutter" -> {
                    runOnUiThread {
                        // Slight delay so dialog can appear before closing
                        window.decorView.postDelayed({ finish() }, 300)
                    }
                    result.success(null)
                }
            }
        }

        MethodChannel(shopEngine.dartExecutor.binaryMessenger, PAYMENT_CHANNEL)
            .setMethodCallHandler(channelHandler)

        MethodChannel(paymentEngine.dartExecutor.binaryMessenger, PAYMENT_CHANNEL)
            .setMethodCallHandler(channelHandler)

        findViewById<Button>(R.id.shopButton).setOnClickListener {
            startActivity(
                FlutterActivity.withCachedEngine(SHOP_ENGINE).build(this)
            )
        }

        findViewById<Button>(R.id.paymentButton).setOnClickListener {
            startActivity(
                FlutterActivity.withCachedEngine(PAYMENT_ENGINE).build(this)
            )
        }
    }

    private fun showDialog(message: String) {
        AlertDialog.Builder(this)
            .setTitle("Callback Received")
            .setMessage(message)
            .setPositiveButton("OK", null)
            .show()
    }
}
