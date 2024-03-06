import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';
import 'DrawerPages/Home/offline_page.dart';

class Paymentgetway extends StatefulWidget {
  String orderid;
  String url;
  String amount;
  Paymentgetway(
      {required this.amount, required this.orderid, required this.url});

  @override
  State<Paymentgetway> createState() => _PaymentgetwayState();
}

class _PaymentgetwayState extends State<Paymentgetway> {
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print("started ---$url");
          },
          onPageFinished: (String url) {
            print("finished ---$url");
            if (url.contains('status=failed')) {
              print("failed=========== ");
              // await paymentCheck();
              // if (paymentStatusModel.data?.orderPaymentStatusText == "Paid") {
              //   await sucessPayment1();
              // } else {
              Fluttertoast.showToast(msg: "Payment Failed ");
              Navigator.pop(context);
              // }
              print("+++++++++++++++++++++=");
              // Get.off(() => AddMoney());

              /// Navigator.pop(context);
              // return NavigationDecision.prevent;
            } else if (url.contains("status=success")) {
              print("++++++++HERE PAYMENT+++++++++++++=");

              Fluttertoast.showToast(msg: "Money Add Successfully");
              Navigator.push(context, MaterialPageRoute(builder: (context) => OfflinePage("")));
              // return NavigationDecision.prevent;
            }
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) async {
          //   print("herererereerer be navigaet ${request.url} ");
          //   if (request.url.contains('cancelTransaction')) {
          //     print("failed=========== ");
          //     // await paymentCheck();
          //     // if (paymentStatusModel.data?.orderPaymentStatusText == "Paid") {
          //     //   await sucessPayment1();
          //     // } else {
          //       Fluttertoast.showToast(msg: "Payment Failed ");
          //       Navigator.pop(context);
          //     // }
          //     print("+++++++++++++++++++++=");
          //     // Get.off(() => AddMoney());
          //
          //     /// Navigator.pop(context);
          //     return NavigationDecision.prevent;
          //   } else if (request.url.contains("status=success")) {
          //     print("++++++++HERE PAYMENT+++++++++++++=");
          //
          //     Fluttertoast.showToast(msg: "Payment Successfully");
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => SearchLocationPage()));
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        title: Text("Payment"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
            // Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(child: WebViewWidget(controller: _controller)),
    );
  }
}

class PAYMENTSUCESSMODEL {
  String? code;
  bool? status;
  String? mess;
  Data? data;

  PAYMENTSUCESSMODEL({this.code, this.status, this.mess, this.data});

  PAYMENTSUCESSMODEL.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    mess = json['mess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['mess'] = this.mess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderKeyId;
  String? orderAmount;
  String? orderId;
  String? orderStatus;
  String? orderPaymentStatus;
  Null? orderPaymentStatusText;
  String? paymentStatus;
  Null? paymentTransactionId;
  String? paymentResponseCode;
  Null? paymentTransactionRefNo;
  Null? paymentResponseText;
  Null? paymentMethod;
  Null? paymentAccount;
  Null? paymentDateTime;
  Null? updatedDateTime;
  Null? orderPaymentTransactionDetail;
  String? paymentProcessUrl;

  Data(
      {this.orderKeyId,
        this.orderAmount,
        this.orderId,
        this.orderStatus,
        this.orderPaymentStatus,
        this.orderPaymentStatusText,
        this.paymentStatus,
        this.paymentTransactionId,
        this.paymentResponseCode,
        this.paymentTransactionRefNo,
        this.paymentResponseText,
        this.paymentMethod,
        this.paymentAccount,
        this.paymentDateTime,
        this.updatedDateTime,
        this.orderPaymentTransactionDetail,
        this.paymentProcessUrl});

  Data.fromJson(Map<String, dynamic> json) {
    orderKeyId = json['OrderKeyId'];
    orderAmount = json['OrderAmount'];
    orderId = json['OrderId'];
    orderStatus = json['OrderStatus'];
    orderPaymentStatus = json['OrderPaymentStatus'];
    orderPaymentStatusText = json['OrderPaymentStatusText'];
    paymentStatus = json['PaymentStatus'];
    paymentTransactionId = json['PaymentTransactionId'];
    paymentResponseCode = json['PaymentResponseCode'];
    paymentTransactionRefNo = json['PaymentTransactionRefNo'];
    paymentResponseText = json['PaymentResponseText'];
    paymentMethod = json['PaymentMethod'];
    paymentAccount = json['PaymentAccount'];
    paymentDateTime = json['PaymentDateTime'];
    updatedDateTime = json['UpdatedDateTime'];
    orderPaymentTransactionDetail = json['OrderPaymentTransactionDetail'];
    paymentProcessUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderKeyId'] = this.orderKeyId;
    data['OrderAmount'] = this.orderAmount;
    data['OrderId'] = this.orderId;
    data['OrderStatus'] = this.orderStatus;
    data['OrderPaymentStatus'] = this.orderPaymentStatus;
    data['OrderPaymentStatusText'] = this.orderPaymentStatusText;
    data['PaymentStatus'] = this.paymentStatus;
    data['PaymentTransactionId'] = this.paymentTransactionId;
    data['PaymentResponseCode'] = this.paymentResponseCode;
    data['PaymentTransactionRefNo'] = this.paymentTransactionRefNo;
    data['PaymentResponseText'] = this.paymentResponseText;
    data['PaymentMethod'] = this.paymentMethod;
    data['PaymentAccount'] = this.paymentAccount;
    data['PaymentDateTime'] = this.paymentDateTime;
    data['UpdatedDateTime'] = this.updatedDateTime;
    data['OrderPaymentTransactionDetail'] = this.orderPaymentTransactionDetail;
    data['PaymentProcessUrl'] = this.paymentProcessUrl;
    return data;
  }
}
