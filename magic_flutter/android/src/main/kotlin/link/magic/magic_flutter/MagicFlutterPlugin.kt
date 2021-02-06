package link.magic.magic_flutter

import android.app.Activity
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import link.magic.android.Magic
import link.magic.android.modules.auth.requestConfiguration.LoginWithMagicLinkConfiguration
import link.magic.android.modules.auth.response.DIDToken
import link.magic.android.modules.user.requestConfiguration.UpdateEmailConfiguration
import link.magic.android.modules.user.response.GetMetadataResponse
import link.magic.android.modules.user.response.IsLoggedInResponse
import link.magic.android.modules.user.response.LogoutResponse
import link.magic.android.modules.user.response.UpdateEmailResponse

/** MagicFlutterPlugin */
class MagicFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    // Error constants
    private val errorCode: String = "FAILED"
    private val loginErrorMessage: String = "Failed to login"
    private val commonErrorDetail: String = "Something went wrong"
    private val isLoggedInErrorMessage: String = "Failed to check user status"
    private val logOutErrorMessage: String = "Failed to logout"
    private val updateEmailErrorMessage: String = "Failed to update E-mail"
    private val fetchMetaDataErrorMessage: String = "Failed to fetch user meta-data"

    // Keys
    private val publisherKey: String = "publisherKey"
    private val emailKey: String = "email"

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var magicSDK: Magic? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "magic")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initializeMagic" -> initializeMagicSDK(call = call, result = result)
            "loginWithMagicLink" -> loginWithMagicLink(call = call, result = result)
            "isLoggedIn" -> isLoggedIn(result = result)
            "logout" -> logout(result = result)
            "updateEmail" -> updateEmail(call = call, result = result)
            "getMetaData" -> getMetaData(result = result)
            else -> result.notImplemented()
        }
    }

    private fun initializeMagicSDK(call: MethodCall, result: Result) {
        if (activity != null) {
            magicSDK = Magic(activity as Activity, call.argument<String>(publisherKey) as String)
            result.success(true)
        } else {
            result.success(false)
        }
    }

    private fun getMetaData(result: Result) {
        if (magicSDK != null) {
            val completableFuture = magicSDK!!.user.getMetadata()

            completableFuture.whenComplete { response: GetMetadataResponse?, error: Throwable? ->
                if (response != null && !response.hasError()) {
                    val responseMap = mapOf("email" to response.result.email, "issuer" to response.result.issuer, "publicAddress" to response.result.publicAddress)
                    sendResult(responseMap, result)
                } else if (error != null) {
                    sendError(fetchMetaDataErrorMessage, error.message, result)
                } else {
                    sendError(fetchMetaDataErrorMessage, commonErrorDetail, result)
                }
            }
        } else {
            sendSDKNotInitializeError(result)
        }
    }

    private fun updateEmail(call: MethodCall, result: Result) {
        if (magicSDK != null) {
            val completableFuture = magicSDK!!.user.updateEmail(UpdateEmailConfiguration(email = call.argument<String>(emailKey) as String))

            completableFuture.whenComplete { response: UpdateEmailResponse?, error: Throwable? ->
                when {
                    response != null && !response.hasError() -> {
                        sendResult<Boolean>(response.result, result)
                    }
                    error != null -> {
                        sendError(updateEmailErrorMessage, error.message, result)
                    }
                    else -> {
                        sendResult(false, result)
                    }
                }
            }
        } else {
            sendSDKNotInitializeError(result)
        }
    }

    private fun logout(result: Result) {
        if (magicSDK != null) {
            val completableFuture = magicSDK!!.user.logout()

            completableFuture.whenComplete { response: LogoutResponse?, error: Throwable? ->
                if (error != null)
                    sendError(logOutErrorMessage, error.message, result)

                if (response != null && response.result) {
                    sendResult<Boolean>(response.result, result)
                }
            }

        } else {
            sendSDKNotInitializeError(result)
        }
    }

    private fun isLoggedIn(result: Result) {
        if (magicSDK != null) {
            val completableFuture = magicSDK!!.user.isLoggedIn()
            completableFuture.whenComplete { response: IsLoggedInResponse?, error: Throwable? ->
                if (error != null)
                    sendError(isLoggedInErrorMessage, error.message, result)

                if (response != null && response.result) {
                    sendResult<Boolean>(response.result, result)
                } else {
                    sendResult(false, result)
                }
            }
        } else {
            sendSDKNotInitializeError(result)
        }

    }

    private fun loginWithMagicLink(call: MethodCall, result: Result) {
        if (magicSDK != null) {
            val completableFuture = magicSDK!!.auth.loginWithMagicLink(LoginWithMagicLinkConfiguration(email = call.argument<String>("email") as String))

            completableFuture.whenComplete { response: DIDToken?, error: Throwable? ->
                if (error != null)
                    sendError(loginErrorMessage, error.message, result)

                if (response != null && !response.hasError()) {
                    val responseMap = mapOf("id" to response.id, "result" to response.result, "jsonRpc" to response.jsonrpc, "rawResponse" to response.rawResponse)
                    sendResult<Map<String, Any>>(responseMap, result)
                } else {
                    sendError(loginErrorMessage, commonErrorDetail, result)
                }
            }
        } else {
            sendSDKNotInitializeError(result)
        }
    }

    private fun sendSDKNotInitializeError(result: Result) {
        result.error(errorCode, "Magic SDK not initialized. Make sure, you have called Magic.initializeMagic", null)
    }

    private fun <T>sendResult(response: T, result: Result) {
        Handler(Looper.getMainLooper()).post {
            result.success(response)
        }
    }

    private fun sendError(errorMessage: String, errorDetails: String?, result: Result) {
        Handler(Looper.getMainLooper()).post {
            result.error(errorCode, errorMessage, errorDetails)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }
}
