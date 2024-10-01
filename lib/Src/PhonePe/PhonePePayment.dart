// import 'package:flutter/material.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
//
// class PhonePePayment extends StatefulWidget {
//   const PhonePePayment({super.key});
//
//   @override
//   State<PhonePePayment> createState() => _PhonePePaymentState();
// }
//
// class _PhonePePaymentState extends State<PhonePePayment> {
//   String environment = "UAT_SIM";
//   String appId = "df1f45af-e8bd-496d-b416-ec2450f0920f";
//   String merchantId = "GETIFYBUSINESSONLINE";
//   bool enableLogging = false;
//   String saltkey = "df1f45af-e8bd-496d-b416-ec2450f0920f";
//   String saltindex = "1";
//   String callbackUrl = "1";
//   String body = "";
//
//   Object? result;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     phonepeInit();
//   }
//
//   phonepeInit() {
//     PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
//         .then((val) => {
//               setState(() {
//                 result = 'PhonePe SDK Initialized - $val';
//               })
//             })
//         .catchError((error) {
//       handleError(error);
//       return <dynamic>{};
//     });
//   }
//
//   getcheckSum() {
//     final responseData = {
//       "merchantId": merchantId,
//       "merchantTransactionId": "transaction_123",
//       "merchantUserId": "90223250",
//       "amount": 1000,
//       "mobileNumber": "9999999999",
//       "callbackUrl": "https://webhook.site/callback-url",
//       "paymentInstrument": {
//         "type": "PAY_PAGE",
//       },
//     };
//     // String bas64Body = base64.encode(utf8.encoder())
//   }
//
//   startPgtranaction() async {
//     try {
//       var response = PhonePePaymentSdk.startTransaction(body, "", "", "");
//       response
//           .then((val) => {
//                 setState(() {
//                   if (val != null) {
//                     String status = val["status"].toString();
//                     String error = val["error"].toString();
//
//                     if (status == "SUCCESS") {
//                       print("Flow Complete - status : SUCCESS");
//                     } else {
//                       print("Flow Complete - status : ERROR-> ${error}");
//                     }
//                   }
//
//                   result = val;
//                 })
//               })
//           .catchError((error) {
//         handleError(error);
//         return <dynamic>{};
//       });
//     } catch (error) {
//       handleError(error);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
//
//   void handleError(error) {
//     setState(() {
//       result = {"error": error};
//     });
//   }
// }
