
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Const/route.dart';
import '../aamarpay/aamarpay.dart';
import '../controllar/membershipUpdate/membershipUpdate.dart';
import '../controllar/userprofileController/userProfileController.dart';
import 'package:http/http.dart' as http;



class MemberShipPage extends StatefulWidget {
  String mambershipName;
   MemberShipPage({Key? key,required this.mambershipName}) : super(key: key);

  @override
  State<MemberShipPage> createState() => _MemberShipPageState();
}

class _MemberShipPageState extends State<MemberShipPage> {
  Map<String, dynamic>? paymentIntentData;
  var loader = true;
  @override
  void initState() {

    final membershipUpdate = Provider.of<MembershipUpdate>(context, listen: false);
    Timer.run(() {
      membershipUpdate.load(widget.mambershipName, context).then((value) => loader=false);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    final membershipUpdate = Provider.of<MembershipUpdate>(context, listen: true);
  //  load();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child:
        Padding(
          padding: EdgeInsets.only(top: 20,right: 25),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10).r,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:  Icon(
                  Icons.arrow_back_ios, size: 25.w,  color: Colors.black,),
              ),
            ),
            centerTitle: true,
            title:  Text(
                'মেম্বারশীপ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'IrabotiMJ',
                )
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: loader ?
      Center(child: CircularProgressIndicator(),):
      Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/backgroundImage.png",
                fit: BoxFit.cover,
              )),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height*0.15),
                membershipUpdate.selectIndex==0? SvgPicture.asset(
                  "assets/silverBox.svg",
                ): membershipUpdate.selectIndex==1?SvgPicture.asset(
                 "assets/memberShipBox.svg",
               ):SvgPicture.asset(
                 "assets/diamontBox.svg",
               ),

               profile.loder?Center(child: CircularProgressIndicator(),) : Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   child: Container(
                    //     height: 50,
                    //     width: size.width,
                    //     color: Color(0xffE51D20),
                    //     child:Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         for(var i=0;i<profile.membershipModel!.msg!.length;i++)
                    //           InkWell(
                    //             onTap: (){
                    //               setState(() {
                    //                 celectIndex=i;
                    //               });
                    //             },
                    //             child: Container(
                    //               height: 50,
                    //               width: 85,
                    //
                    //               color:celectIndex==i?Color(0xffB60003):Color(0xffE51D20),
                    //
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(5),
                    //                 child: Center(
                    //                   child: Text(
                    //                       profile.membershipModel!.msg![i].title!,
                    //                       textAlign: TextAlign.center,
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 15,
                    //                        // fontFamily: 'IrabotiMJ',
                    //                       )
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //
                    //         ],
                    //     )
                    //
                    //
                    //
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   child: AnimatedSwitcher(
                    //       duration: Duration(
                    //         microseconds: 200,),
                    //     child:   Container(
                    //       height:410,
                    //       width: 370,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           color: Colors.white
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           ListTile(
                    //             dense: true,
                    //             contentPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    //             leading:CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor:Color(0xffEAEAEA),
                    //               child:SvgPicture.asset("assets/postlimit.svg"),
                    //
                    //             ),
                    //             title: Text(
                    //                 'Post Limit',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //                 )
                    //             ),
                    //             trailing:Text(
                    //                 '${profile.membershipModel!.msg![celectIndex].privilege!.postLimit!}',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //           ),
                    //           Divider(
                    //             indent: 10,
                    //             endIndent: 10,
                    //           ),
                    //           ListTile(
                    //             dense: true,
                    //             contentPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    //             leading:CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor:Color(0xffEAEAEA),
                    //               child:SvgPicture.asset("assets/applylimit.svg"),
                    //
                    //             ),
                    //             title: Text(
                    //                 'Apply Limit',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //             trailing:Text(
                    //                 "${profile.membershipModel!.msg![celectIndex].privilege!.applyLimit!}",
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //           ),
                    //           Divider(
                    //             indent: 10,
                    //             endIndent: 10,
                    //           ),
                    //           ListTile(
                    //             dense: true,
                    //             contentPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    //             leading:CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor:Color(0xffEAEAEA),
                    //               child:SvgPicture.asset("assets/phone.svg"),
                    //
                    //             ),
                    //             title: Text(
                    //                 'Phone',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //             trailing:Text(
                    //                 '${profile.membershipModel!.msg![celectIndex].privilege!.phone!}',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //           ),
                    //           Divider(
                    //             indent: 10,
                    //             endIndent: 10,
                    //           ),
                    //           ListTile(
                    //             dense: true,
                    //             contentPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    //             leading:CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor:Color(0xffEAEAEA),
                    //               child:SvgPicture.asset("assets/cetagory.svg"),
                    //
                    //             ),
                    //             title: Text(
                    //                 'Category',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //             trailing:Text(
                    //                 '${profile.membershipModel!.msg![celectIndex].privilege!.category!}',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //           ),
                    //           Divider(
                    //             indent: 10,
                    //             endIndent: 10,
                    //           ),
                    //           ListTile(
                    //             dense: true,
                    //             contentPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    //             leading:CircleAvatar(
                    //               radius: 15,
                    //               backgroundColor:Color(0xffEAEAEA),
                    //               child:SvgPicture.asset("assets/price.svg"),
                    //
                    //             ),
                    //             title: Text(
                    //                 'Price',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //             trailing:Text(
                    //                 '${profile.membershipModel!.msg![celectIndex].price}',
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.normal,
                    //
                    //                 )
                    //             ),
                    //           ),
                    //           SizedBox(height: 20,),
                    //
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(horizontal: 15),
                    //             child: InkWell(
                    //               onTap: (){
                    //                 update();
                    //               },
                    //               child: Container(
                    //                 height: 41,
                    //                 width: 285,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(51),
                    //                     color: Color(0xffE51D20)
                    //                 ),
                    //                 child:Center(
                    //                   child: Text(
                    //                       "Upgrade Membership",
                    //                       textAlign: TextAlign.center,
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 15,
                    //
                    //                       )
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Table(
                          border: TableBorder.all(color: Colors.black.withOpacity(0.05), width: 1.5,
                          borderRadius: BorderRadius.circular(15)),
                          columnWidths: const {
                            0: FlexColumnWidth(130),
                            1: FlexColumnWidth(85),
                            2: FlexColumnWidth(85),
                            3:FlexColumnWidth(85)
                          },
                          children: [
                            TableRow(
                                children: [
                                  SizedBox(width: 15,),
                                  for(var i=0;i<profile.membershipModel!.msg!.length;i++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                              profile.membershipModel!.msg![i].title!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                // fontFamily: 'IrabotiMJ',
                                              )
                                          ),
                                          Text(
                                              "${profile.membershipModel!.msg![i].price!}/মাস",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                 fontFamily: 'Inter',
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text("লিংক লিমিট",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        // fontFamily: 'IrabotiMJ',
                                      )),
                                    ),
                                  ),
                                  for(var j=0;j<profile.membershipModel!.msg!.length;j++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          profile.membershipModel!.msg![j].privilege!.postLimit.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                             // fontWeight: FontWeight.bold,
                                              fontFamily: 'IrabotiMJ',
                                              fontSize: 18.sp,
                                            ),
                                          ),

                                          // style: TextStyle(
                                          //   color: Colors.black,
                                          //   fontSize: 18,
                                          //   fontFamily: 'Inter',
                                          // )

                                      ),
                                    ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("এপ্লাই লিমিট",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        // fontFamily: 'IrabotiMJ',
                                      )),
                                    ),
                                  ),
                                  for(var j=0;j<profile.membershipModel!.msg!.length;j++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          profile.membershipModel!.msg![j].privilege!.applyLimit.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                             fontFamily: 'Inter',
                                          )
                                      ),
                                    ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("ক্যাটাগরি",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        // fontFamily: 'IrabotiMJ',
                                      )),
                                    ),
                                  ),
                                  for(var j=0;j<profile.membershipModel!.msg!.length;j++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          profile.membershipModel!.msg![j].privilege!.category.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                             fontFamily: 'Inter',
                                          )
                                      ),
                                    ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("ফোন এক্সেস",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        // fontFamily: 'IrabotiMJ',
                                      )),
                                    ),
                                  ),
                                  for(var j=0;j<profile.membershipModel!.msg!.length;j++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          profile.membershipModel!.msg![j].privilege!.phone.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                             fontFamily: 'Inter',
                                          )
                                      ),
                                    ),
                                ]
                            ),
                            // TableRow(
                            //     children: [
                            //       Center(
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Text("Price",style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 18,
                            //             // fontFamily: 'IrabotiMJ',
                            //           )),
                            //         ),
                            //       ),
                            //       for(var j=0;j<profile.membershipModel!.msg!.length;j++)
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Text(
                            //               profile.membershipModel!.msg![j].price.toString(),
                            //               textAlign: TextAlign.center,
                            //               style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontSize: 18,
                            //                 // fontFamily: 'IrabotiMJ',
                            //               )
                            //           ),
                            //         ),
                            //     ]
                            // ),
                            TableRow(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                         fontFamily: 'IrabotiMJ',
                                      )),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      // update(0);
                                      newPage(context: context, child: MyPay(index: 0, membershipName: widget.mambershipName));

                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0).r,
                                        child:Container(
                                          height: 31,
                                          width: 62,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: membershipUpdate.selectIndex==0?Colors.black.withOpacity(0.5):Colors.red,
                                          ),
                                          child: Center(
                                            child:   SvgPicture.asset(
                                              "assets/email.svg",
                                              height: 15.h,
                                              width: 16.w,
                                              color: Colors.white,
                                            ),
                                          ),

                                        )

                                        // Text(membershipUpdate.selectIndex==0?"Selected":"Select",style: TextStyle(
                                        //   color: membershipUpdate.selectIndex==0?Colors.black:Colors.red,
                                        //   fontSize: 14.sp,
                                        //   // fontFamily: 'IrabotiMJ',
                                        // )),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      // update(1);
                                      newPage(context: context, child: MyPay(index: 1, membershipName: widget.mambershipName,));
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0).r,
                                        child:Container(
                                          height: 31,
                                          width: 62,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: membershipUpdate.selectIndex==1?Colors.black.withOpacity(0.5):Colors.red,
                                          ),
                                          child: Center(
                                            child:   SvgPicture.asset(
                                              "assets/email.svg",
                                              height: 15.h,
                                              width: 16.w,
                                              color: Colors.white,
                                            ),
                                          ),

                                        )

                                        // Text(membershipUpdate.selectIndex==1?"Selected":"Select",style: TextStyle(
                                        //   color: membershipUpdate.selectIndex==1?Colors.black:Colors.red,
                                        //   fontSize: 14.sp,
                                        //   // fontFamily: 'IrabotiMJ',
                                        // )),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      // update(2);
                                      newPage(context: context, child: MyPay(index:2 ,membershipName: widget.mambershipName));

                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0).r,
                                        child: Container(
                                          height: 31,
                                          width: 62,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: membershipUpdate.selectIndex==2?Colors.black.withOpacity(0.5):Colors.red,
                                          ),
                                          child: Center(
                                            child:   SvgPicture.asset(
                                              "assets/email.svg",
                                              height: 15.h,
                                              width: 16.w,
                                              color: Colors.white,
                                            ),
                                          ),

                                        )

                                        // Text( membershipUpdate.selectIndex==2?"Selected":"Select",style: TextStyle(
                                        //   color:  membershipUpdate.selectIndex==2?Colors.black:Colors.red,
                                        //   fontSize: 14.sp,
                                        //   // fontFamily: 'IrabotiMJ',
                                        // )),
                                      ),
                                    ),
                                  ),
                                ]
                            ),

                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   child: InkWell(
                    //     onTap: (){
                    //       update();
                    //     },
                    //     child: Container(
                    //       height: 41,
                    //       width: 285,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(51),
                    //           color: Color(0xffE51D20)
                    //       ),
                    //       child:Center(
                    //         child: Text(
                    //             "Upgrade Membership",
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 15,
                    //
                    //             )
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          )
        ],

      ),
    );
  }

//   Future<void> makePayment() async {
//     try {
//       paymentIntentData =
//       await createPaymentIntent('20', 'USD'); //json.decode(response.body);
//       // print('Response body==>${response.body.toString()}');
//       await Stripe.instance
//           .initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               setupIntentClientSecret: 'Your Secret Key',
//               paymentIntentClientSecret:
//               paymentIntentData!['client_secret'],
//               //applePay: PaymentSheetApplePay.,
//               //googlePay: true,
//               //testEnv: true,
//               customFlow: true,
//               style: ThemeMode.dark,
//               // merchantCountryCode: 'US',
//               merchantDisplayName: 'Kashif'))
//           .then((value) {});
//
//       ///now finally display payment sheeet
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('Payment exception:$e$s');
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance
//           .presentPaymentSheet(
//         //       parameters: PresentPaymentSheetParameters(
//         // clientSecret: paymentIntentData!['client_secret'],
//         // confirmPayment: true,
//         // )
//       )
//           .then((newValue) {
//         print('payment intent' + paymentIntentData!['id'].toString());
//         print(
//             'payment intent' + paymentIntentData!['client_secret'].toString());
//         print('payment intent' + paymentIntentData!['amount'].toString());
//         print('payment intent' + paymentIntentData.toString());
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("paid successfully")));
//
//         paymentIntentData = null;
//       }).onError((error, stackTrace) {
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//             content: Text("Cancelled "),
//           ));
//     } catch (e) {
//       print('$e');
//     }
//   }
//
// //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount('20'),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization': 'Bearer ' + 'your token',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }
//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }

}


