package com.fastpay.fastpay;

import android.content.Context;
import android.content.Intent;
import android.app.Activity;
import android.os.Handler;
import android.provider.ContactsContract;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;



import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import com.fastpay.payment.model.merchant.FastpayRequest;
import com.fastpay.payment.model.merchant.FastpayResult;
import com.fastpay.payment.model.merchant.FastpaySDK;

import java.util.Map;


/** FastpayPlugin */
public class FastpayPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity activity;
  private Result mResult;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fastpay");
    context = flutterPluginBinding.getApplicationContext();


    channel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("FastPayRequest")) {
      final Map<String,Object> getData = call.arguments();
      // this vrible get from Flutter initial
      // orderID must be unique id
      // isProduction bool with if False this with SANDBOX (TEST) if true with PRODUCTION
      String storeId = (String)getData.get("storeID");
      String storePassword = (String)getData.get("storePassword");
      String orderId = (String)getData.get("orderID");
      String amount = (String)getData.get("amount");
      boolean isProduction = (boolean)getData.get("isProduction");

      FastpayRequest request = new FastpayRequest(context, storeId,storePassword , amount, orderId, isProduction ? FastpaySDK.PRODUCTION : FastpaySDK.SANDBOX);
      mResult = result;

      if (activity != null) {
        try {
              final Intent intent = request.getIntent();
              activity.startActivityForResult(intent, 1999);
        } catch (Exception e) {
          mResult.success("{\"isSuccess\":false,\"errorMessage\":\""+e.getMessage()+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");
        }
      }
    } else {
      result.notImplemented();
    }
  }





  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    activity = null;
  }


  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }


  @Override
  public boolean onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    if (requestCode == 1999) {
      switch (resultCode) {
        case Activity.RESULT_OK:
          if (data != null && data.hasExtra(FastpayResult.EXTRA_PAYMENT_RESULT)) {
            FastpayResult result = data.getParcelableExtra(FastpayResult.EXTRA_PAYMENT_RESULT);
            //? is payment success
            mResult.success("{\"isSuccess\":true,\"errorMessage\":\"\",\"transactionStatus\":\""+result.getTransactionStatus()+"\",\"transactionId\":\""+result.getTransactionId()+"\",\"orderId\":\""+result.getOrderId()+"\",\"paymentAmount\":\""+result.getPaymentAmount()+"\",\"paymentCurrency\":\""+result.getPaymentCurrency()+"\",\"payeeName\":\""+result.getPayeeName()+"\",\"payeeMobileNumber\":\""+result.getPayeeMobileNumber()+"\",\"paymentTime\":\""+result.getPaymentTime()+"\"}");
          }
          break;

        //? is payment Failed
        case Activity.RESULT_CANCELED:
          if (data != null && data.hasExtra(FastpayRequest.EXTRA_PAYMENT_MESSAGE)) {
            String message = data.getStringExtra(FastpayRequest.EXTRA_PAYMENT_MESSAGE);
            //? is payment fail any fastPay resource cancel
            mResult.success("{\"isSuccess\":false,\"errorMessage\":\""+message+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");

          } else {
            //? is payment back
            mResult.success("{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");
          }
          break;
        default:
          //? is payment for any other resource cancel
          mResult.success("{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");
          break;
      }
    }
    return true;
  }
}
