import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../FollowerView/followerView.dart';
import '../Following/FollowingView.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../login/Login_page.dart';
import '../membership/membershipPage.dart';
import '../profile_page/edit_profile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    var size = MediaQuery.of(context).size;
    ///
    return Stack(
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: const Radius.circular(15).w,
                    bottomLeft: Radius.circular(15)).w,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/profileImage.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 22, right: 22),
                    child:
                        AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:  Icon(
                              Icons.arrow_back_ios, size: 25.w,  color:Colors.white,),
                          ),
                          title: Text("সেটিংস",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'IrabotiMJ',
                              )),
                          centerTitle: true,
                          actions: [ SvgPicture.asset(
                            "assets/menuImage.svg",
                            height: 22,
                            width: 16,
                            color: Colors.white,
                          ),],
                        ),
                  ),
                  SizedBox(height: 10),

                  profile.profile!.msg!.userData!.pic == null?
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/unnamed.png"),
                        )
                            ),
                  ):
                  CachedNetworkImage(
                    imageUrl: "$media${profile.profile!.msg!.userData!.pic}",
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
                  // Container(
                  //   height: 90,
                  //   width: 90,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       image: profile.profile!.msg!.userData!.pic == null
                  //           ? DecorationImage(
                  //               image: AssetImage("assets/unnamed.png"),
                  //             )
                  //           : DecorationImage(
                  //               fit: BoxFit.cover,
                  //               image: NetworkImage(
                  //                   "$media${profile.profile!.msg!.userData!.pic}"),
                  //             )),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(profile.profile!.msg!.userData!.fullName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 3,
                  ),
                  Text(profile.profile!.msg!.userData!.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/language.svg"),
                      ),
                      title: Text("Language",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),

                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        newPage(context: context, child: MemberShipPage(mambershipName: '',));
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child:
                            SvgPicture.asset("assets/membershiptypeImage.svg"),
                      ),
                      title: Text("Membership Type",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        newPage(context: context, child: FollowerView());
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/followers.svg"),
                      ),
                      title: Text("Followers",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        newPage(context: context, child: FollowingView());
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/folling.svg"),
                      ),
                      title: Text("Following",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        newPage(context: context, child: EditProfilePage());
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/profileEdit.svg"),
                      ),
                      title: Text("Profile Edit",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/fcg.svg"),
                      ),
                      title: Text("FCM",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Uri url = Uri.parse("https://linkapp.xyz/");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/about.svg"),
                      ),
                      title: Text("About",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Uri url = Uri.parse("https://linkapp.xyz/");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/website.svg"),
                      ),
                      title: Text("Website",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        box.clear();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: SvgPicture.asset("assets/logout.svg"),
                      ),
                      title: Text("Log Out",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 28,
                        color: Color(0xffAEAEAE),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
