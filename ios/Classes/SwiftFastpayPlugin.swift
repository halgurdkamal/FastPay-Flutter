import Flutter
import UIKit
import FastpayMerchantSDK


public class SwiftFastpayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fastpay", binaryMessenger: registrar.messenger())
    let instance = SwiftFastpayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
     print("game")
      var fastpay = ViewController()
      fastpay.callSDK()
      
      
  }
}

class ViewController: UIViewController, FastPayDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func callSDK(){
        let testObj = Fastpay(storeId: "1953_693", storePassword: "Password100@", orderId: "order240", amount: 500, currency: .IQD)
        testObj.delegate = self
        testObj.start(in: self, for: .Sandbox)
    }
    
    func fastpayTransactionSucceeded(with transaction: FPTransaction) {

        if let transactionId = transaction.transactionId, let orderID = transaction.orderId, let billAmount = transaction.amount, let currency = transaction.currency, let customerMobileNo = transaction.customerMobileNo, let name = transaction.customerName, let status = transaction.status, let transactionTime = transaction.transactionTime{
            print("Transaction ID : (transactionId)")
            print("Order ID : (orderID)")
            print("Amount : (orderID)")
            print("Bill Amount : (billAmount)")
            print("Currency : (currency)")
            print("Mobile Number : (customerMobileNo)")
            print("Name : (name)")
            print("Status : (status)")
            print("Transaction Time : (transactionTime)")
        }
    }
    
    func fastpayTransactionFailed(with orderId: String) {
        print("Failed Order ID: (orderId)")
    }
}
