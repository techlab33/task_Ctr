import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../imageView/imageView.dart';
import '../message/messagepage.dart';
import '../model/ApplyListModel/ApplyListModek.dart';
import '../network/ApplyList/list.dart';
import '../widget/audioView.dart';
import '../widget/thumbView.dart';

class ApplyListPage extends StatefulWidget {
  final String id;
  final String counetname;
  const ApplyListPage({Key? key, required this.id, required this.counetname}) : super(key: key);

  @override
  State<ApplyListPage> createState() => _ApplyListPageState();
}

class _ApplyListPageState extends State<ApplyListPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      appBar:   AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
            "এপ্লিকেশন লিস্ট",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'IrabotiMJ',
                color: Colors.black
            )
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10).r,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Icon(
              Icons.arrow_back_ios, size: 25.w, color: Colors.black,),
          ),
        ),
      ),
      body: Stack(
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
                // AppBar(
                //   elevation: 0,
                //   backgroundColor: Colors.transparent,
                //   title: Text(
                //       "এপ্লিকেশন লিস্ট",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontFamily: 'IrabotiMJ',
                //           color: Colors.black
                //       )
                //   ),
                //   centerTitle: true,
                //   leading: Padding(
                //     padding: const EdgeInsets.only(left: 10).r,
                //     child: IconButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       icon:  Icon(
                //         Icons.arrow_back_ios, size: 25.w, color: Colors.black,),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20,),
                Text(
                  "${widget.counetname}",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                FutureBuilder<ApplyListModel?>(
                  future: JobApplyListRepo().applyList(widget.id),
                  builder: (context, ss) {
                    if (ss.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (ss.hasData) {
                      print('ApplicetionListPost ID :${widget.id}');
                      var dataList = ss.data!.msg!;
                      return Padding(
                          padding:EdgeInsets.only(left: 20, right: 20,),
                          child: ListView.builder(
                              itemCount: dataList.length,
                              primary: false,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index){
                                var data = dataList[index];
                                return  Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          "আবেদনকারী নাম : ${data.applicantName}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "সময়ঃ ${data.time}",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    print(data.ownerId!+"fuad");
                                                    print(data.userId!+"fuad");
                                                    newPage(context: context, child: MessagePage(applyid: data.applyId!, jobid: data.jobId!, senderid: box.get('userid'), recvid: data.userId!, name:data.applicantName!,));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: const Color(0xffF2F3F4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        "মেসেজ দিন",
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 11.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                  onTap:(){
                                                     directcall(data.applicantPhone.toString());

                                                    // print(data.ownerId!+"fuad");
                                                    // print(data.userId!+"fuad");
                                                    // newPage(context: context, child: MessagePage(applyid: data.applyId!, jobid: data.jobId!, senderid: box.get('userid'), recvid: data.userId!, name:data.applicantName!,));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: const Color(0xffF2F3F4)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                                      child: Text(
                                                        "কল দিন",
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 11.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, ),
                                        child: Text(
                                          "নোটঃ ${data.note}",
                                          textAlign: TextAlign.start,
                                          maxLines: 300,
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              height: 2.h,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (data.doc!.audio!.first != "" || data.doc!.image!.isNotEmpty || data.doc!.video!.first != "")
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: SizedBox(
                                            height:  size.height * 0.13,
                                            width: size.width,
                                            // color: Color(0xffD9D9D9),
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics: const BouncingScrollPhysics(),
                                              children: [
                                                SizedBox(width: 3.w,),
                                                if (data.doc!.audio!.first != "")
                                                  AudioView(audio: data.doc!.audio!.first,),
                                                SizedBox(width: 2.w,),
                                                if (data.doc!.image!.isNotEmpty)
                                                  for (int img = 0; img < data.doc!.image!.length; img++)
                                                    InkWell(
                                                      onTap: () {
                                                        newPage(
                                                            context: context,
                                                            child: ImageView(
                                                              image:data.doc!.image!,
                                                              shareLink: "",
                                                              hedarText: "",
                                                              connectId: "",
                                                              postName: "",
                                                              discription: "",
                                                              procolpo:"", timeAgo: "", ownerId: "", from: true, page: img,check: true,
                                                            ));
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 8, ),
                                                        child: CachedNetworkImage(
                                                          imageUrl: Uri.decodeFull(
                                                              "$media${data.doc!.image![img]}"),
                                                          imageBuilder: (context, imageProvider) =>
                                                              Container(
                                                                height: size.height * 0.22,
                                                                width: 75,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  image: DecorationImage(
                                                                    image: imageProvider,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                          progressIndicatorBuilder:
                                                              (context, url, downloadProgress) =>
                                                              SkeletonLine(
                                                                style: SkeletonLineStyle(
                                                                    height: size.height * 0.22,
                                                                    width: 180,
                                                                    borderRadius: BorderRadius.circular(25)),
                                                              ),
                                                          errorWidget: (context, url, error) => Container(
                                                              height: size.height * 0.22,
                                                              width: 180.w,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.black.withOpacity(0.2),
                                                                  borderRadius:
                                                                  BorderRadius.circular(25)),
                                                              child: const Icon(Icons.error)),
                                                        ),
                                                      ),
                                                    ),
                                                //fff jjjj jjjj
                                                SizedBox(width: 2,),
                                                if (data.doc!.video!.first != "")
                                                  ThumbView(video: data.doc!.video!.first,)
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );

                              }),
                        );
                    } else {
                      return Center(
                        child: Text("No Job found"),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  directcall(String phonenumber)async{
   // const number = phonenumber; //set the number here
    await FlutterPhoneDirectCaller.callNumber(phonenumber);
  }

}