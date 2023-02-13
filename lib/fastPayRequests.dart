import 'dart:convert';

import 'fastpay.dart';

Future<FastpayResult> FastPayRequest({
  required String storeID,
  required String storePassword,
  required String amount,
  required String orderID,
  bool isProduction = false,
}) async {
  try {
    final _fastpayPlugin = Fastpay();
    String _fastpayPluginResult = await _fastpayPlugin.getPlatformVersion({
          "storeID": storeID,
          "storePassword": storePassword,
          "amount": amount,
          "orderID": orderID,
          "isProduction": isProduction,
        }) ??
        'null';
    if (_fastpayPluginResult == "null") {
      return FastpayResult(
          isSuccess: false,
          errorMessage: "Unknown",
          transactionStatus: "",
          transactionId: "",
          orderId: "",
          paymentAmount: "",
          paymentCurrency: "",
          payeeName: "",
          payeeMobileNumber: "",
          paymentTime: "");
    }

    Map<String, dynamic>? data = jsonDecode(_fastpayPluginResult);
    return FastpayResult.fromJson(data ??
        {
          "isSuccess": false,
          "errorMessage": "null",
          "transactionStatus": "",
          "transactionId": "",
          "orderId": "",
          "paymentAmount": "",
          "paymentCurrency": "",
          "payeeName": "",
          "payeeMobileNumber": "",
          "paymentTime": ""
        });
  } catch (e) {
    return FastpayResult(
        isSuccess: false,
        errorMessage: e.toString(),
        transactionStatus: "",
        transactionId: "",
        orderId: "",
        paymentAmount: "",
        paymentCurrency: "",
        payeeName: "",
        payeeMobileNumber: "",
        paymentTime: "");
  }
}

class FastpayResult {
  final bool? isSuccess;
  final String? transactionStatus;
  final String? transactionId;
  final String? orderId;
  final String? paymentAmount;
  final String? paymentCurrency;
  final String? payeeName;
  final String? payeeMobileNumber;
  final String? paymentTime;
  final String? errorMessage;

  FastpayResult({
    this.isSuccess,
    this.transactionStatus,
    this.transactionId,
    this.orderId,
    this.paymentAmount,
    this.paymentCurrency,
    this.payeeName,
    this.payeeMobileNumber,
    this.paymentTime,
    this.errorMessage,
  });

  factory FastpayResult.fromJson(Map<String, dynamic> json) {
    return FastpayResult(
      isSuccess: json['isSuccess'] ?? false,
      transactionStatus: json['transactionStatus'] ?? '',
      transactionId: json['transactionId'] ?? '',
      orderId: json['orderId'] ?? '',
      paymentAmount: json['paymentAmount'] ?? '',
      paymentCurrency: json['paymentCurrency'] ?? '',
      payeeName: json['payeeName'] ?? '',
      payeeMobileNumber: json['payeeMobileNumber'] ?? '',
      paymentTime: json['paymentTime'] ?? '',
      errorMessage: json['errorMessage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'transactionStatus': transactionStatus,
      'transactionId': transactionId,
      'orderId': orderId,
      'paymentAmount': paymentAmount,
      'paymentCurrency': paymentCurrency,
      'payeeName': payeeName,
      'payeeMobileNumber': payeeMobileNumber,
      'paymentTime': paymentTime,
      'errorMessage': errorMessage,
    };
  }
}
