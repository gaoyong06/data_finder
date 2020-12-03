package cn.com.datarangers.data_finder

import android.content.Context
import android.text.TextUtils
import androidx.annotation.NonNull
import com.bytedance.applog.AppLog
import com.bytedance.applog.ILogger
import com.bytedance.applog.InitConfig
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONException
import org.json.JSONObject
import kotlin.math.log


/** DataFinderPlugin */
class DataFinderPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "data_finder")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "init" -> init(call, result)
            "setUserUniqueID" -> setUserUniqueID(call, result)
            "onEventV3" -> onEventV3(call, result)
            else -> result.notImplemented()
        }
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    private fun init(@NonNull call: MethodCall, @NonNull result: Result) {
        val appId = call.argument<String>("appId")
        if (TextUtils.isEmpty(appId)) {
            println("appId不能为空")
            result.error("-1", "appId不能为空", "请检查appId")
            return
        }
        val channel: String = call.argument<String>("channel") ?: ""
        val showLog: Boolean = call.argument<Boolean>("showLog") ?: false
        println("appId: $appId===========channel: $channel")
        val logger = ILogger { s, _ -> if (showLog) println(s) }
        AppLog.init(context, InitConfig(appId!!, channel).setAutoStart(true).setLogger(logger))
        result.success(true)
    }

    private fun setUserUniqueID(@NonNull call: MethodCall, @NonNull result: Result) {
        val userUniqueID = call.argument<String>("userUniqueID")
        if (TextUtils.isEmpty(userUniqueID)) {
            println("userUniqueID不能为空")
            result.error("-1", "userUniqueID不能为空", "请检查userUniqueID")
            return
        }
        println("userUniqueID: $userUniqueID===========")
        AppLog.setUserUniqueID(userUniqueID);
        result.success(true)
    }

    private fun onEventV3(@NonNull call: MethodCall, @NonNull result: Result) {
        val event = call.argument<String>("event")
        if (TextUtils.isEmpty(event)) {
            println("event不能为空")
            result.error("-1", "event不能为空", "请检查event")
            return
        }
        val params = call.argument<Map<String, *>>("params")
        println("event: $event===========params: $params")
        if (params == null) {
            AppLog.onEventV3(event!!)
        } else {
            val paramsObj = JSONObject()
            try {
                for ((key, value) in params) {
                    paramsObj.put(key, value)
                }
            } catch (e: JSONException) {
                e.printStackTrace()
            }
            AppLog.onEventV3(event!!, paramsObj)
        }
        result.success(true)
    }

}
