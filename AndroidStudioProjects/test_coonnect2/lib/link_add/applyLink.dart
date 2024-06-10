
import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import 'package:provider/provider.dart';
import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import 'package:path/path.dart' as join;
import 'dart:io';

import '../network/NotificationSend/Notification.dart';

import '../network/fileUpload/upload.dart';
import 'Audio.dart';
import 'ImagePickersScreens.dart';

class ApplyLinkPage extends StatefulWidget {
  final String jobId;
  final String ownerId;
  final String title;

   ApplyLinkPage(
      {Key? key, required this.jobId,
        required this.ownerId,
        required this.title,
      })
      : super(key: key);

  @override
  State<ApplyLinkPage> createState() => _ApplyLinkPageState();
}

class _ApplyLinkPageState extends State<ApplyLinkPage> {

  UploadFile fileUpload = UploadFile();
  File? audioFile;
  TextEditingController note = TextEditingController();
  var category = "1";
  var selected = "বড় প্রকল্প সমূহ";
  List<Media> mediaList = [];
  String time = "অনির্ধারিত";
  Color color =  Colors.grey;
  Color color1 = Colors.grey;
  // final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddLinkControllar>(context, listen: false)
          .changeColor(Colors.grey);
    });
    // TODO: implement initState
    super.initState();
  }
  List <String> imageName = [];


  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddLinkControllar>(context, listen: true);
    final categoryController = Provider.of<CategoricContrllar>(
        context, listen: false);
    var size = MediaQuery
        .of(context)
        .size;

    final configs = ImagePickerConfigs();
    // AppBar text color
    configs.appBarTextColor = Colors.white;
    configs.appBarBackgroundColor = Colors.red;
    // Disable select images from album
    // configs.albumPickerModeEnabled = false;
    // Only use front camera for capturing
    // configs.cameraLensDirection = 0;
    // Translate function
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
    // Disable edit function, then add other edit control instead
    configs.adjustFeatureEnabled = false;
    configs.externalImageEditors['external_image_editor_1'] = EditorParams(
        title: 'Editor',
        icon: Icons.edit_rounded,
        onEditorEvent: (
            {required BuildContext context,
              required File file,
              required String title,
              int maxWidth = 1080,
              int maxHeight = 1920,
              int compressQuality = 90,
              ImagePickerConfigs? configs}) async =>
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImageEdit(
                    file: file,
                    title: title,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,

                    configs: configs))));
    // configs.externalImageEditors['external_image_editor_2'] = EditorParams(
    // title: 'external_image_editor_2',
    // icon: Icons.edit_attributes,
    // onEditorEvent: (
    // {required BuildContext context,
    // required File file,
    // required String title,
    // int maxWidth = 1080,
    // int maxHeight = 1920,
    // int compressQuality = 90,
    // ImagePickerConfigs? configs}) async =>
    // Navigator.of(context).push(MaterialPageRoute(
    // fullscreenDialog: true,
    // builder: (context) => ImageSticker(
    // file: file,
    // title: title,
    // maxWidth: maxWidth,
    // maxHeight: maxHeight,
    // configs: configs))));
    // Example about label detection & OCR extraction feature.
    // You can use Google ML Kit or TensorflowLite for this purpose
    configs.labelDetectFunc = (String path) async {
      return <DetectObject>[
        DetectObject(label: 'dummy1', confidence: 0.75),
        DetectObject(label: 'dummy2', confidence: 0.75),
        DetectObject(label: 'dummy3', confidence: 0.75)
      ];
    };
    configs.ocrExtractFunc =
        (String path, {bool? isCloudService = false}) async {
      if (isCloudService!) {
        return 'Cloud dummy ocr text';
      } else {
        return 'Dummy ocr text';
      }
    };
    configs.appBarDoneButtonColor = Colors.black;
    // Example about custom stickers
    configs.customStickerOnly = false;
    configs.customStickers = [
      'assets/icon/cus1.png',
      'assets/icon/cus2.png',
      'assets/icon/cus3.png',
      'assets/icon/cus4.png',
      'assets/icon/cus5.png'
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(height: 20,),
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
                  AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
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
                    title: Row(
                      children: [
                        const Text(
                            'প্রস্তাবনা পাঠান / ',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontFamily: 'IrabotiMJ'
                            )
                        ),
                           Text(
                               widget.title, overflow: TextOverflow.visible,
                               style: TextStyle(
                             color: Colors.red,
                            fontSize: 18.sp,
                      // fontFamily: 'IrabotiMJ'
                    ))
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      // height: size.height*0.85,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16).w,
                          color: Colors.white
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  SizedBox(height: 10.h,),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(widget.title, style: TextStyle(
                          //       color: Colors.red,
                          //       fontSize: 18.sp,
                          //      // fontFamily: 'IrabotiMJ'
                          //   )
                          //   ),
                          // ),
                          //  SizedBox(height: 10.h,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text('কানেক্ট আইডিঃ ${widget.jobId}',  style:  TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: 16.sp,
                          //         fontFamily: 'IrabotiMJ'
                          //     )),
                          //      SizedBox(width: 10.w,),
                          //     Text('মালিকের আইডিঃ ${widget.jobId}',  style:  TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: 16.sp,
                          //         fontFamily: 'IrabotiMJ'
                          //
                          //     )),
                          //   ],
                          // ),
                           SizedBox(height: 15.h,),
                           Align(
                            alignment: Alignment.center,
                            child: Text(
                                'নিচের তথ্যগুলো পূরণ করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.sp,
                                    fontFamily: 'IrabotiMJ'
                                )
                            ),
                          ),
                           SizedBox(height: 10.h,),
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                                'কাজটি করতে কেমন সময় লাগবে?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                    fontFamily: 'IrabotiMJ'

                                )
                            ),
                          ),
                           SizedBox(height: 10.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 50.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5).w,
                                  color: const Color(0xffFAFAFA),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: DropdownSearch<String>(
                                dropdownBuilder: (context, selectedItem) {
                                  return Text(
                                    selectedItem!,
                                    style: const TextStyle(fontFamily: 'Kalpurush'),
                                  );
                                },
                                popupProps: const PopupProps.menu(),
                                items: [
                                  "অনির্ধারিত",
                                  "২ দিনের মত",
                                  "৪ দিনের মত",
                                  "১ সপ্তাহ",
                                  '২ সপ্তাহ',
                                  '৩ সপ্তাহ',
                                  '১ মাস',
                                  '2 মাস'
                                ],
                                dropdownDecoratorProps:  DropDownDecoratorProps(
                                    textAlign: TextAlign.left,
                                    dropdownSearchDecoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(12).w,
                                        border: InputBorder.none
                                    )
                                ),
                                // hint: "কাজটি করতে কেমন সময় লাগবে?",
                                selectedItem: "কাজটি করতে কেমন সময় লাগবে?",
                                onChanged: (value) {
                                  setState(() {
                                    time = value!;
                                  });
                                },
                              ),
                            ),
                          ),

                           SizedBox(height: 10.h,),
                           SizedBox(height: 10.h,),
                           Align(
                            alignment: Alignment.center,
                            child: Text(
                                'ছবি/ভিডিও/অডিও যুক্ত করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.sp,
                                    fontFamily: 'IrabotiMJ'
                                )
                            ),
                          ),
                           SizedBox(height: 10.h,),
                           Divider(
                            height: 3,
                            thickness: 1.5,
                            endIndent: 10,
                            indent: 10,
                          ),
                           SizedBox(height: 10.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var file = await controller
                                          .picVideoFIle();
                                      if (file != null) {
                                        var joinpath = join.basename(file.path);
                                        var check = await fileUpload.uploaddile(
                                            file.path);
                                        if (check != null || check == true) {
                                          setState(() {
                                            color = Colors.red;
                                          });
                                        }
                                        // final uint8list = await VideoThumbnail.thumbnailData(
                                        //   video: file.path,
                                        //   imageFormat: ImageFormat.JPEG,
                                        //   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                        //   quality: 25,
                                        // );

                                        print("DDDD>>${joinpath}");
                                      }
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          color: Color(0xffFAFAFA),
                                          border: Border.all(color: color)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/videoCall.svg",
                                          color: const Color(0xffC6C6C6),

                                        ),
                                      ),
                                    ),
                                  ),
                                   Positioned(
                                      right: -12,
                                      top: -5,
                                      child: CircleAvatar(
                                          radius: 13.w,
                                          backgroundColor: Colors.red,
                                          child: const Icon(Icons.add, size: 22,
                                            color: Colors.white,)))

                                ],
                              ),


                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImagePickerScreen(),
                                    ),
                                  );
                                  // final picker = ImagePicker();
                                  // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                  //
                                  // if (pickedFile != null) {
                                  //   List<String> data = [];
                                  //   print(pickedFile.path);
                                  //   await fileUpload.uploaddile(pickedFile.path).then((value) {
                                  //     if (value != null) {
                                  //       color1 = Colors.red;
                                  //       setState(() {});
                                  //     }
                                  //   });
                                  //
                                  //   setState(() {
                                  //     data.add(pickedFile.path);
                                  //     imageName.add('\"${join.basename(pickedFile.path)}\"');
                                  //   });
                                  // }

                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  color: color1,
                                  child: Text('Pick Images'),
                                ),
                              ),



                              Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      RecoderButtomSheet();
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          color: Color(0xffFAFAFA),
                                          border: Border.all(color: controller.color)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/audio.svg",
                                          color: const Color(0xffC6C6C6),

                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                      right: -12,
                                      top: -5,
                                      child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.add, size: 22,
                                            color: Colors.white,)))

                                ],
                              ),
                            ],
                          ),
                           SizedBox(height: 10.h,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                                'Note',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,

                                )
                            ),
                          ),
                           SizedBox(height: 10.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: note,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xff3E4040)),
                              decoration: InputDecoration(
                                hintText: 'Write your notes about the attachments',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xff3E4040)),
                                filled: true,
                                fillColor: const Color(0xffFAFAFA),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1
                                    )
                                ),

                              ),

                            ),
                          ),
                           SizedBox(height: 20.h,),
                          InkWell(
                            onTap: () async {
                              var box = Hive.box("login");
                              controller.applyLink(
                                  category: category,
                                  time: time,
                                  jobid: widget.jobId,
                                  ownerId: widget.ownerId,
                                  imageName: imageName,
                                  note: note.text).then((value) {
                                NotificationRepo().notificationSend(
                                    type: 'new_apply',
                                    content: "${box.get(
                                        "name")} apply your job",
                                    receiverId: widget.ownerId);
                                Navigator.pop(context);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25),
                              child: Container(
                                height: 41.h,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(51),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text(
                                      'প্রস্তাবনা সম্পূর্ন করুন',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'IrabotiMJ'
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ),
                           SizedBox(height: 20.h,),

                        ],

                      ),
                    ),
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void RecoderButtomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (context) {
          return const RecordExample();
        }
    );
  }

  // void openImagePicker(BuildContext context) {
  //   // openCamera(onCapture: (image){
  //   //   setState(()=> mediaList = [image]);
  //   // });
  //   final controller = Provider.of<AddLinkControllar>(context, listen: false);
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return MediaPicker(
  //           mediaList: mediaList,
  //           //let MediaPicker know which medias are already selected by passing the previous mediaList
  //           onPick: (selectedList) async {
  //             var check = await controller.uploadImage(selectedList);
  //             print(check);
  //             if (check != null || check == true) {
  //               color1 = Colors.red;
  //             }
  //             Navigator.pop(context);
  //             print('Got Media ${selectedList.length}');
  //           },
  //           onCancel: () => print('Canceled'),
  //           mediaCount: MediaCount.multiple,
  //           mediaType: MediaType.image,
  //           decoration: PickerDecoration(
  //             loadingWidget:
  //
  //             Shimmer.fromColors(
  //               baseColor: Colors.red,
  //               highlightColor: Colors.yellow, child: const SizedBox(
  //               width: 200.0,
  //               height: 100.0,
  //             ),
  //             ),
  //
  //
  //           ),
  //         );
  //       });
  // }


}
