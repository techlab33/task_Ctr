import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllar/membershipUpdate/membershipUpdate.dart';
import '../controllar/userprofileController/userProfileController.dart';

class MyPay extends StatefulWidget {
  final int index;
  final String membershipName;

  const MyPay({super.key, required this.index, required this.membershipName});
  @override
  MyPayState createState() => MyPayState();
}
class MyPayState extends State<MyPay> {
  bool isLoading = false;

  @override 
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final membershipUpdate = Provider.of<MembershipUpdate>(context, listen: false);
    var userData=profile.profile!.msg!.userData!;
    return Scaffold(
      body: Center(
        child: Aamarpay(
          // This will return a payment url based on failUrl,cancelUrl,successUrl
          returnUrl: (String url) {
            print(url);
          },
          // This will return the payment loading status
          isLoading: (bool loading) {
            setState(() {
              isLoading = loading;
            });
          },
          // This will return the payment state with a message
          status: (EventState event, String message) {
            print(event);
            print("fuad$message");
            if (event == EventState.success) {
              membershipUpdate.update(widget.index, context,widget.membershipName ).then((value){
                // membershipUpdate.load(widget.membershipName, context);

              });
            }
          },
          cancelUrl: "https://www.merchantdomain.com/index.html",
          successUrl: "https://www.merchantdomain.com/sucess_page.php",
          failUrl: "https://www.merchantdomain.com/failed_page.php",
          customerEmail: "${userData.email}",
          customerMobile: "${userData.phone}",
          customerName: "${userData.fullName}",
          // That is the test signature key. But when you go to the production you must use your own signature key
          signature: "dbb74894e82415a2f7ff0ec3a97e4183",
          // That is the test storeID. But when you go to the production you must use your own storeID
          storeID: "aamarpaytest",
          // Use transactionAmountFromTextField when you pass amount with TextEditingController
          // transactionAmountFromTextField: amountTextEditingController,
          transactionAmount: "200",
          //The transactionID must be unique for every payment
          transactionID: "${DateTime.now().millisecondsSinceEpoch}",
          description: "test",
          // When the application goes to the producation the isSandbox must be false
          isSandBox: true,
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container(
            color: Colors.orange,
            height: 50,
            child: Center(
              child: Text(
                "Payment",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}