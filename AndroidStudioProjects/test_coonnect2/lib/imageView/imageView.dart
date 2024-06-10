import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeletons/skeletons.dart';

import '../Const/const.dart';
import '../Const/route.dart';
import '../link_add/applyLink.dart';
import '../user_profile/user_profile.dart';

class ImageView extends StatefulWidget {
  final List image;
  final String hedarText;
  final String connectId;
  final String postName;
  final String shareLink;
  final String discription;
  final String procolpo;
  final String timeAgo;
  final String ownerId;
  final bool from;
  final bool check;
  final int page;

  const ImageView(
      {Key? key,
      required this.image,
      required this.hedarText,
      required this.connectId,
      required this.postName,
      required this.procolpo,
      required this.discription,
      required this.timeAgo,
      required this.ownerId, required this.from, required this.page, required this.shareLink, required this.check})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> with SingleTickerProviderStateMixin {
  var box=Hive.box("login");

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.hedarText,
        text: widget.discription,
        linkUrl: widget.shareLink,
        chooserTitle: widget.hedarText);
  }

  TransformationController controllar=TransformationController();
  TapDownDetails? tapDownDetails;
  int page =0;
   PageController? pageController;
 AnimationController ?animationController;

  Animation<Matrix4>? animation;
  bool isFirstPage() {
    print("fast");
    print(page == 0);
    return page == 0;
  }

  bool isLastPage() {
    print("last");
    print(page == widget.image.length-1);
    return page == widget.image.length-1;
  }

 @override
  void initState() {
   animationController=AnimationController(vsync: this,
   duration: const Duration(milliseconds: 200))..addListener(() {
     controllar.value=animation!.value;
   });
pageController = PageController(
  initialPage: widget.page,

);

   WidgetsBinding.instance.addPostFrameCallback((_) {
     setState(() {
       page = widget.page;
     });
   });
    super.initState();
  }
  @override
  void dispose() {
    controllar.dispose();
    animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
print(widget.page.toString()+"fuad");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            )),

      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            children: [
              PageView.builder(
                itemCount: widget.image.length,
                controller: pageController,
                onPageChanged: (p){
                  setState(() {
                    page= p;
                  });
                  print(page);
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onDoubleTapDown: (details){
                        tapDownDetails=details;
                      },
                      onDoubleTap: (){
                        const double scale=3;
                        final position =tapDownDetails!.localPosition;
                        final x=-position.dx*(scale-1);
                        final y=-position.dy*(scale-1);
                        final zoomed=Matrix4.identity()
                          ..translate(x,y)
                          ..scale(scale);
                        final end=controllar.value.isIdentity()? zoomed:Matrix4.identity();
                        animation=Matrix4Tween(
                            begin: controllar.value,
                            end:end
                        ).animate(
                            CurveTween(curve: Curves.easeOut).animate(animationController!)
                        );
                        animationController!.forward(from: 0);
                      },
                      child: InteractiveViewer(
                        clipBehavior: Clip.none,
                        transformationController: controllar,
                        panEnabled: true,
                        scaleEnabled: true,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: Uri.decodeFull("$media${widget.image[index]}"),
                            imageBuilder: (context, imageProvider) =>

                                Container(
                                  height: size.height,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: imageProvider,

                                    ),
                                  ),
                                ),
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                      height: size.height,
                                      width: size.width,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                            errorWidget: (context, url, error) => Container(
                                height: size.height,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Icon(Icons.error)),
                          ),
                        ),
                      ));
                },
              ),
              isLastPage()?Container():
              Align(
                alignment: Alignment.centerRight,
                child:  CircleAvatar(
                  radius: 15,
                  backgroundColor:Colors.black.withOpacity(0.3),
                  child: Center(
                    child: IconButton(onPressed: (){
                      nextPage();
                    }, icon: Icon(Icons.arrow_forward_ios_outlined,size: 13,)),
                  ),
                )
              ),
              isFirstPage()?
                   Container():
              Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor:Colors.black.withOpacity(0.3),
                    child: Center(
                      child: IconButton(onPressed: (){
                        previousPage();
                      }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 13,)),
                    ),
                  )
              )
            ],
          ),
          if(widget.from==false)
          DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.1,
              maxChildSize: 0.7,
              builder: (context, c) {
                return Container(
                  color: Colors.white,
                  child: ListView(
                    controller: c,
                    padding: EdgeInsets.zero,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          widget.hedarText,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xffF2F3F4)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.procolpo,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Post: ",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              TextSpan(
                                  text: widget.timeAgo,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.3),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ))
                            ])),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                newPage(
                                    context: context,
                                    child: UserProfilePage(id: widget.ownerId));
                              },
                              child: Text(
                                widget.postName.split(" ")[0].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "কানেক্ট আইডি :",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'IrabotiMJ',
                                  )),
                              TextSpan(
                                text: widget.connectId,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            ])),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          widget.discription,
                          textAlign: TextAlign.start,
                          maxLines: 30,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              height: 2,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: widget.check? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                newPage(
                                    context: context,
                                    child: ApplyLinkPage(
                                      jobId: widget.connectId,
                                      ownerId: widget.ownerId,
                                      title: widget.hedarText,

                                    ));

                              },
                              child: Container(
                                height: 45,
                                width: size.width*0.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.redAccent
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/bookImage.svg",
                                        height: 18.h,
                                        width: 18.w,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        'প্রস্তাবনা দিন',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                            SizedBox(width: 15,),
                            InkWell(
                              onTap: (){
                                share();
                              },
                              child: Container(
                                height:45,
                                width: size.width*0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.redAccent
                                ),
                                child: Center(
                                  child:   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/sahre.svg",
                                        height: 18.h,
                                        width: 18.w,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        'শেয়ার',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ),
                            )
                          ],
                        ):Container()
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
   nextPage(){
   print("next Page");
   pageController!.animateToPage(pageController!.page!.toInt() + 1,
        duration: Duration(microseconds: 1),
        curve: Curves.easeIn
    );
  }

   previousPage(){
     pageController!.animateToPage(pageController!.page!.toInt() -1,
        duration: Duration(milliseconds: 4),
        curve: Curves.easeIn
    );
  }
}


