import Flutter
import UIKit
import FastpayMerchantSDK


public class SwiftFastpayPlugin: UIViewController, FlutterPlugin, FastPayDelegate {
    var resultG: FlutterResult!
    var isPresented: Bool = false
    var timer: Timer?

   public func fastpayTransactionSucceeded(with transaction: FPTransaction) {
       isPresented = true
       print("return sesses \(isPresented)")
       if let transactionId = transaction.transactionId, let orderID = transaction.orderId, let billAmount = transaction.amount, let currency = transaction.currency, let customerMobileNo = transaction.customerMobileNo, let name = transaction.customerName, let status = transaction.status, let transactionTime = transaction.transactionTime{
           
           resultG("{\"isSuccess\":true,\"errorMessage\":\"\",\"transactionStatus\":\"\(status)\",\"transactionId\":\"\(transactionId)\",\"orderId\":\"\(orderID)\",\"paymentAmount\":\"\(billAmount)\",\"paymentCurrency\":\"IQD\",\"payeeName\":\"\(name)\",\"payeeMobileNumber\":\"\(customerMobileNo)\",\"paymentTime\":\"\(transactionTime)\"}")
       }
           
       
    }
    
   public func fastpayTransactionFailed(with orderId: String) {
        print("Failed Order ID: \(orderId)")
       resultG("{\"isSuccess\":false,\"errorMessage\":\""+"\(orderId)"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}")
    }

    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fastpay", binaryMessenger: registrar.messenger())
    let instance = SwiftFastpayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      resultG = result;
     
      do{
          guard let args = call.arguments as? [String: Any] else {
              return
          }
          let storeId = args["storeID"] as! String
          let storePassword = args["storePassword"] as! String
          let orderId = args["orderID"] as! String
          let amount = args["amount"] as! String
          let isProduction = args["isProduction"] as! Bool
         
      let amounts = Int(amount)
      let testObj = Fastpay(storeId: storeId, storePassword: storePassword, orderId: orderId ,
                            amount: amounts!, currency: .IQD)
                testObj.delegate = self
  let uiContoller = (UIApplication.shared.keyWindow?.rootViewController!)!
          let x =  testObj.start(in: uiContoller, for: isProduction ? .Production : .Sandbox)
  

  timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
      if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        if rootVC.presentedViewController != nil {
          
        } else {
            print("return exit \(self?.isPresented)")
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                print("return call result \(self?.isPresented)")
                if(!self!.isPresented == true){
                    self?.resultG("{\"isSuccess\":false,\"errorMessage\":\""+"Cancel"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}")
                }
              
          }
        }
      }
  }
  
  
  print(x)
  print("_____________")
      } catch let e{
          result("{\"isSuccess\":false,\"errorMessage\":\""+"\(e)"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}")
      }
    

      
      
    
//      let navigationController = UINavigationController(rootViewController: fastpay)
//      present(navigationController, animated: true, completion: nil)
//      navigationController.viewDidLoad
//      do{
//          let randomInt = Int.random(in: 0..<1000000)
//          let testObj = Fastpay(storeId: "748908_339", storePassword: "R3D)BYN;w", orderId: String(randomInt) , amount: 500, currency: .IQD)
//          testObj.delegate = self
//          testObj.start(in: (UIApplication.shared.keyWindow?.rootViewController!)!, for: .Sandbox)  { result in
//              switch result {
//              case .success(let transaction):
//                  print(transaction)
//              case .failure(let error):
//                  print(error)
//              }
//          }
//
//
//      } catch let error {
//          print(error.localizedDescription)
//      }
  }
    
}


