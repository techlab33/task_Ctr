import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../link_add/link_add_page.dart';
import '../membership/membershipPage.dart';
import '../widget/drawer_widget.dart';
import 'edit_pro_pic.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var chack = 0;
  var show = 6;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: false);
    var data = profile.profile!.msg!.userData!;
    var startAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profile.profile!.msg!.membership!.startDate ?? "00000") *
            1000);
    var endDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(profile.profile!.msg!.membership!.endDate ?? "00000") * 1000);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Set this height
        child: Stack(
          children: [
            Container(
              height: size.height *0.12,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/profileImage.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text('প্রোফাইল',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'IrabotiMJ')),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 25,
                      ),
                    ))
              ],
            ),

          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          newPage(context: context, child: const LinkAddPage());
        },
        child: SvgPicture.asset("assets/addLink.svg"),
      ),
      endDrawer: Drawer(
        width: size.width,
        child: const SingleChildScrollView(child: DrawerWidget()),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  "assets/backgroundImage.png",
                  fit: BoxFit.cover,
                )),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.35,
                      width: size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/profileImage.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 25, top: 20, right: 25),
                    //   child: AppBar(
                    //     automaticallyImplyLeading: false,
                    //     title: const Text('প্রোফাইল',
                    //         textAlign: TextAlign.start,
                    //         style: TextStyle(
                    //             fontSize: 18, fontFamily: 'IrabotiMJ')),
                    //     elevation: 0,
                    //     centerTitle: true,
                    //     backgroundColor: Colors.transparent,
                    //     actions: [
                    //       InkWell(
                    //           onTap: () {
                    //             scaffoldKey.currentState!.openEndDrawer();
                    //           },
                    //           child: const Icon(
                    //             Icons.menu,
                    //             color: Colors.white,
                    //             size: 25,
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.24,
                        left: 15,
                        right: 15,
                      ).r,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: size.height * 0.35,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20).w,
                                color: Colors.white),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Text('${data.fullName}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text('${data.profileTagline}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/phone.svg",
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Text('${data.phone}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.h,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/email.svg",
                                        height: 12.h,
                                        width: 15.w,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text('${data.email}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    newPage(
                                        context: context,
                                        child: const EditProfilePage());
                                  },
                                  child: Container(
                                    height: 41,
                                    width: 171,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.red,
                                        border: Border.all(
                                            color: Colors.red, width: 1.w)),
                                    child: Center(
                                      child: Text('এডিট প্রোফাইল',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'IrabotiMJ',
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: -size.height * 0.075,
                            child: data.pic == null
                                ? Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/unnamed.png"),
                                        )

                                        // DecorationImage(
                                        //   fit: BoxFit.cover,
                                        //   image:   NetworkImage("$media${data.pic}"),
                                        // )
                                        ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: "$media${data.pic}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 90.h,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        height: 90.h,
                                        width: 90.w,
                                        shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(50)
                                            .w, // Adjust the border radius as needed
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                          ),
                          Positioned(
                              top: -size.height * 0.01,
                              right: size.width * 0.3,
                              child: InkWell(
                                onTap: () {
                                  // newPage(context: context, child: ChangeProfilePic());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const ChangeProfilePic());
                                },
                                child: CircleAvatar(
                                  radius: 19.w,
                                  backgroundColor: const Color(0xffD9D9D9),
                                  child: Center(
                                      child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: Colors.black,
                                  )),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 15, top: 20),
                                      child: Text('ক্যাটাগরী',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontFamily: 'IrabotiMJ',
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const CategoryDialog());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, top: 20),
                                        child: SvgPicture.asset(
                                          "assets/write.svg",
                                          height: 19,
                                          width: 21,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                GridView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    // physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0.3,
                                            mainAxisSpacing: 0.9,
                                            childAspectRatio: 1.3),
                                    itemCount:
                                        show > profile.servicesByName.length
                                            ? profile.servicesByName.length
                                            : show,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          InkWell(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Container(
                                               // height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    color: Colors.red,
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(
                                                        profile
                                                            .servicesByName[index],
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'IrabotiMJ',
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -15,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child:
                            InkWell(
                              onTap: (){
                                if (show ==
                                    categoryController
                                        .catagoriclist.msg!.length ||
                                    show >
                                        categoryController
                                            .catagoriclist.msg!.length) {
                                  setState(() {
                                    show = 6;
                                  });
                                } else {
                                  setState(() {
                                    show = show + 6;
                                  });
                                }
                              },
                              child: show ==
                                  categoryController
                                      .catagoriclist.msg!.length ||
                                  show >
                                      categoryController
                                          .catagoriclist.msg!.length?CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey.withOpacity(0.3),
                                  child: Center(child: SvgPicture.asset("assets/more2.svg",height: 22,width: 22,))): CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  child: Center(child: SvgPicture.asset("assets/more.svg",height: 22,width: 22,))),
                            ),
                            
                            // IconButton(
                            //
                            //   padding: EdgeInsets.zero,
                            //   icon: Icon(
                            //     show ==
                            //         categoryController
                            //             .catagoriclist.msg!.length ||
                            //         show >
                            //             categoryController
                            //                 .catagoriclist.msg!.length
                            //         ? Icons.arrow_circle_up
                            //         : Icons.arrow_circle_down,
                            //     color: Colors.red.withOpacity(0.5),
                            //     size: 22,
                            //   ),
                            //   onPressed: () {
                            //     if (show ==
                            //         categoryController
                            //             .catagoriclist.msg!.length ||
                            //         show >
                            //             categoryController
                            //                 .catagoriclist.msg!.length) {
                            //       setState(() {
                            //         show = 6;
                            //       });
                            //     } else {
                            //       setState(() {
                            //         show = show + 6;
                            //       });
                            //     }
                            //   },
                            // ),
                            alignment: Alignment.center,
                          ),

                          // CircleAvatar(
                          //   radius: 16,
                          //   backgroundColor: Colors.grey.withOpacity(0.2),
                          //   child: Center(
                          //     child: IconButton(
                          //       icon: Icon(
                          //         show ==
                          //                     categoryController
                          //                         .catagoriclist.msg!.length ||
                          //                 show >
                          //                     categoryController
                          //                         .catagoriclist.msg!.length
                          //             ? Icons.arrow_circle_up
                          //             : Icons.arrow_circle_down,
                          //         color: Colors.red.withOpacity(0.5),
                          //         size: 22,
                          //       ),
                          //       onPressed: () {
                          //         if (show ==
                          //                 categoryController
                          //                     .catagoriclist.msg!.length ||
                          //             show >
                          //                 categoryController
                          //                     .catagoriclist.msg!.length) {
                          //           setState(() {
                          //             show = 6;
                          //           });
                          //         } else {
                          //           setState(() {
                          //             show = show + 6;
                          //           });
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: (){},
                  // onTap: () {
                  //   newPage(
                  //       context: context,
                  //       child: MemberShipPage(
                  //         mambershipName:
                  //             profile.profile!.msg!.membership!.packageName ??
                  //                 "",
                  //       ));
                  // },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: size.height * 0.55,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top:10),
                              child: Text('মেম্বারশীপ এরিয়া',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,

                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'IrabotiMJ',
                                  )),
                            ),
                          ),
                          if (profile.profile!.msg!.membership!.packageName !=
                              null)
                            Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 0, top: 0, bottom: 0),
                                  leading: Text('প্যাকেজ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                  title: Text(
                                      profile.profile!.msg!.membership!
                                              .packageName ??
                                          "কোন প্যাকেজ নেই",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        // fontFamily: 'IrabotiMJ',
                                      )),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 0, top: 0, bottom: 0),
                                  leading: const Text('মেয়াদ শুরু',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                  title: Text(
                                    '${DateFormat('MMM dd, yyyy').format(startAt)}',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    // style: TextStyle(
                                    //   color: Colors.black,
                                    //   fontSize: 15,
                                    //   fontWeight: FontWeight.normal,
                                    //   fontFamily: 'IrabotiMJ',
                                    // )
                                  ),
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 0, top: 0, bottom: 0),
                                  leading: const Text('মেয়াদ শেষ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                  title: Text(
                                    '${DateFormat('MMM dd, yyyy').format(endDate)}',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    // style: TextStyle(
                                    //   color: Colors.black,
                                    //   fontSize: 15,
                                    //   fontWeight: FontWeight.normal,
                                    //   fontFamily: 'IrabotiMJ',
                                    // )
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 0, top: 0, bottom: 0),
                                  leading: const Text('অটো রিনিউ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                  title: Text(
                                      profile.profile!.msg!.membership!
                                                  .status! ==
                                              "1"
                                          ? "বন্ধ"
                                          : "চালু",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                ),
                              ],
                            ),
                          if (profile.profile!.msg!.membership!.packageName ==
                              null)
                            const SizedBox(
                              height: 15,
                            ),
                          InkWell(
                            onTap: () {
                              newPage(
                                  context: context,
                                  child: MemberShipPage(
                                    mambershipName:
                                    profile.profile!.msg!.membership!.packageName ??
                                        "",
                                  ));
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 41,
                                width: 265,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(51),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text('মেম্বারশীপ উন্নত করুন',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({Key? key}) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  List<String> animaleint2 = [];

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: false);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Wrap(
                  children: List.generate(
                      categoryController.catagoriclist.msg!.length, (index) {
                    return InkWell(
                      onTap: () {
                        // if (userprevilies.userPrevilies != null &&
                        //     userprevilies.userPrevilies!.msg!.category !=
                        //         animaleint2.length) {
                        if (animaleint2.contains(categoryController
                            .catagoriclist.msg![index].catId)) {
                          setState(() {
                            animaleint2.remove(categoryController
                                .catagoriclist.msg![index].catId);
                          });
                        } else {
                          setState(() {
                            animaleint2.add(categoryController
                                .catagoriclist.msg![index].catId!);
                          });
                        }
                        // } else {
                        //   setState(() {
                        //     animaleint2.remove(
                        //         homeprovider.allcategory!.msg![index].catId);
                        //   });
                        // }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: animaleint2.contains(categoryController
                                    .catagoriclist.msg![index].catId)
                                ? Colors.red
                                : Colors.grey[200]),
                        child: Text(
                          categoryController.catagoriclist.msg![index].catName!,
                          style: TextStyle(
                              color: animaleint2.contains(categoryController
                                      .catagoriclist.msg![index].catId)
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'Kalpurush'),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  profile
                      .profileUpdate(
                    company: "",
                    confirmpass: "",
                    name: "",
                    newpass: "",
                    oldpass: "",
                    phone: "",
                    pic: "",
                    servicearea: animaleint2,
                    profiletag: "",
                  )
                      .then((value) {
                    profile.getProfileInfo();
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  "সাবমিট",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
