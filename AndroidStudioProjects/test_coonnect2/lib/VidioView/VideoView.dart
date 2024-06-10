


import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class VideoViewPage extends StatefulWidget {
  final  String link;
  final  String hedarText;
  final  String procolpo;
  final  String timeAgo;
  final  String postName;
  final  String ownerId;
  final  String connectId;
  final  String discription;
  const VideoViewPage({Key? key, required this.link, required this.hedarText, required this.procolpo, required this.timeAgo, required this.postName, required this.ownerId, required this.connectId, required this.discription}) : super(key: key);

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {

  @override
  Widget build(BuildContext context) {
    print(widget.link);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/backgroundImage.png",
                fit: BoxFit.cover,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 270,
                child: BetterPlayer.network(
                  widget.link,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    placeholderOnTop: false,
                    autoPlay: true,
                    aspectRatio: 9/16,
                    fit: BoxFit.cover,
                    controlsConfiguration: BetterPlayerControlsConfiguration(

                    )
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //   child: Text(
              //     widget.hedarText,
              //     textAlign: TextAlign.start,
              //     style: GoogleFonts.inter(
              //       textStyle: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(50),
              //             color: const Color(0xffF2F3F4)),
              //         child: Padding(
              //           padding: const EdgeInsets.all(4.0),
              //           child: Text(
              //             widget.procolpo,
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.inter(
              //               textStyle: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 11,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       RichText(
              //           text: TextSpan(children: [
              //             TextSpan(
              //               text: "Post: ",
              //               style: GoogleFonts.inter(
              //                 textStyle: TextStyle(
              //                   color: Colors.black.withOpacity(0.3),
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 11,
              //                 ),
              //               ),
              //             ),
              //             TextSpan(
              //                 text:widget.timeAgo,
              //                 style: GoogleFonts.inter(
              //                   textStyle: TextStyle(
              //                     color: Colors.black.withOpacity(0.3),
              //                     fontWeight: FontWeight.w400,
              //                     fontSize: 11,
              //                   ),
              //                 ))
              //           ])),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           newPage(
              //               context: context,
              //               child: UserProfilePage(id: widget.ownerId));
              //         },
              //         child: Text(
              //           widget.postName.split(" ")[0].toString(),
              //           overflow: TextOverflow.ellipsis,
              //           style: GoogleFonts.inter(
              //             textStyle: TextStyle(
              //               color: Colors.black.withOpacity(0.3),
              //               fontWeight: FontWeight.w400,
              //               fontSize: 11,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       RichText(
              //           text: TextSpan(children: [
              //             TextSpan(
              //                 text: "কানেক্ট আইডি :",
              //                 style: TextStyle(
              //                   color: Colors.black.withOpacity(0.3),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                   fontFamily: 'IrabotiMJ',
              //                 )),
              //             TextSpan(
              //               text: widget.connectId,
              //               style: GoogleFonts.inter(
              //                 textStyle: TextStyle(
              //                   color: Colors.black.withOpacity(0.3),
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 11,
              //                 ),
              //               ),
              //             )
              //           ])),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //   child: Text(
              //     widget.discription,
              //     textAlign: TextAlign.start,
              //     maxLines: 30,
              //     style: GoogleFonts.inter(
              //       textStyle: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.w400,
              //         height: 2,
              //         fontSize: 10,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
