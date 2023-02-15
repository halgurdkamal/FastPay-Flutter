# FastPay Iraq Flutter

FastPay Developers Arena
Accept payments with FastPay's APIs. Our simple and easy-to-integrate APIs allow for less effort in processing payments. This is not an official support channel, but our APIs support both Android and iOS.



|<img src="https://github.com/halgurdkamal/FastPay-Flutter/blob/main/asset/payment1.jpg?raw=true" width="250"> |
<img src="https://github.com/halgurdkamal/FastPay-Flutter/blob/main/asset/payment2.jpg?raw=true" width="250"> |

## Quick Glance
- this plugin not Official but build with integrate native Android & IOS that by FastPay published on [FastPay Developers Portal](https://developer.fast-pay.iq/).
- you need contact FastPay to get storeID and Password



## Installation
``` 
dependencies:
  fastpay: ^1.0.2
```

## Android 
- Requires AndroidX

### Build Gradle

 Include support in ```android/app/build.gradle```
add this line if not exit:
```properties
implementation 'com.android.support:appcompat-v7:28.0.0'
```
### styles
 change theme app in ```android/app/src/main/res/values/styles.xml``` and ```android/app/src/main/res/values-night/styles.xml``` to :
##### if you want show appbar with app name title :
```bash 
Theme.AppCompat.Light
```
##### if you do not want show appbar with app name title :
```bash 
Theme.AppCompat.Light.NoActionBar
```
Example :
```properties
<!-- change theme app to AppCompat theme -->
 <style name="LaunchTheme" parent="Theme.AppCompat.Light">
       <!-- update this line to change background payment color to white -->
        <item name="android:windowBackground">#ffffff</item>
       ...

    </style>
```
### Manifest
add this line to  manifest
```properties
<application
       <-- lable name show in fastpay title screen -->
        android:label="example"
       <-- add this line in hear --> 
        android:theme="@style/LaunchTheme"
      ...
>
```

## IOS
It doesn't need to be changed
- iOS only supports real device you can't test it on simulator because FastPay SDK not support simulator

___

### Initiate FastPaySDK

- __Store ID__ : Merchant’s Store Id to initiate transaction
- __Store Password__ : Merchant’s Store password to initiate transaction
- __Order ID__ : Order ID/Bill number for the transaction, this value should be unique in every transaction
- __Amount__ : Payable amount in the transaction ex: “1000”
- __isProduction__ : Payment Environment to initiate transaction (false for test & true for real life transaction)

## Examples 
```dart 
FastpayResult _fastpayResult = await FastPayRequest(
                    storeID: "********", 
                    storePassword: "********",
                    amount: "1000", 
                    orderID: "HBBS7657", 
                     isProduction: false, 
                  );

 if (_fastpayResult.isSuccess ?? false) {
       // transaction success
     } else {
       // transaction failed
     }
```

When __FastPayRequest__ call open FastPay SDK then after payment return __FastpayResult__ that contains:

### payment result 
- __isSuccess__ : return true for a successful transaction else false.
- __errorMessage__ : if transaction failed return failed result 
- __transactionStatus__ : Payment status weather it is success / failed.
- __transactionId__ : If payment is successful then a transaction id will be available.
- __orderId__ : Unique Order ID/Bill number for the transaction which was passed at initiation time.
- __paymentAmount__ : Payment amount for the transaction. “1000”
- __paymentCurrency__ : Payment currency for the transaction. (IQD)
- __payeeName__ : Payee name for a successful transaction.
- __payeeMobileNumber__ :  Number: Payee name for a successful transaction.
- __paymentTime__ : Payment occurrence time as the timestamp.
   



