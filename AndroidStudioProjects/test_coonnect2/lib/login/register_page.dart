import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllar/register/register_controllar.dart';
class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  // @override
  // void dispose() {
  //   final  controller = Provider.of<RegisterControllar>(context,listen: false);
  //   controller.fullNameControllar.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<RegisterControllar>(context,listen: false);
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Text('নতুন একাউন্ট তৈরি করুন', textAlign: TextAlign.center, style: TextStyle(
                color: Color.fromRGBO(229, 29, 32, 1),
                fontFamily: 'IrabotiMJ',
                fontSize: 25,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1
            ),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.fullNameControllar,
                    decoration: InputDecoration(
                      hintText: "নাম",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.profileTaglineControllar,
                    decoration: InputDecoration(
                      hintText: 'প্রফাইল টেগ্লাইন',
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.conpanyNameControllar,
                    decoration: InputDecoration(
                      hintText: "আপনার বর্তমান কোম্পানি",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.phoneControllar,
                    decoration: InputDecoration(
                      hintText: "ফোন",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.emailControllar,
                    decoration: InputDecoration(
                      hintText: "ইমেইল",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,

                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),

                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.passswordControllar,
                    decoration: InputDecoration(
                      hintText: "পাসওয়ার্ড",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,

                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd9d9d9)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,),
                  child: TextField(
                    controller: controller.rePassworddControllar,
                    decoration: InputDecoration(
                      hintText: "পাসওয়ার্ড পুনরায় লিখুন",
                      border:InputBorder.none,
                      hintStyle:   TextStyle(
                        color: Colors.black,
                        fontFamily: 'IrabotiMJ',
                        fontWeight: FontWeight.normal,

                      ),
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(height: 5,),
            InkWell(
              onTap: (){
                controller.getRegister(context);
              },
              child:
              controller.loder?Center(child: CircularProgressIndicator(),): Container(
                  width: 314,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius : BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                    color : Color.fromRGBO(229, 29, 32, 1),
                  ),
                child: Center(
                  child: Text('যুক্ত হোন', textAlign: TextAlign.center, style:
                  TextStyle(
                      color: Color.fromRGBO(242, 243, 244, 1),
                      fontFamily: 'IrabotiMJ',
                      fontSize: 18,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),) ,
                ),
              ),
            ),
             SizedBox(height: 15,),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Text('একাউন্ট আছে? লগ ইন করুন', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(151, 151, 151, 1),
                  fontFamily: 'IrabotiMJ',
                  fontSize: 18,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1
              ),),
            ),
            SizedBox(height: 30,),

          ],
        ),
      )       // Figma Flutter Generator SignupWidget - FRAME

    );
  }
}

