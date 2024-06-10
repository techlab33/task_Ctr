import 'package:advance_image_picker/configs/image_picker_configs.dart';
import 'package:advance_image_picker/models/image_object.dart';
import 'package:advance_image_picker/widgets/editors/editor_params.dart';
import 'package:advance_image_picker/widgets/editors/image_edit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_connect/link_add/ImagePickersScreens.dart';
import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../controllar/categoric_controllar/categoric_controllar.dart';
import 'package:path/path.dart' as join;
import '../controllar/myLink_controller/myLink_controller.dart';
import '../controllar/userprofileController/userProfileController.dart';
import '../network/fileUpload/upload.dart';
import 'Audio.dart';
import 'dart:io';

class LinkAddPage extends StatefulWidget {
  const LinkAddPage({Key? key}) : super(key: key);

  @override
  State<LinkAddPage> createState() => _LinkAddPageState();
}

class _LinkAddPageState extends State<LinkAddPage> {
  UploadFile fileUpload = UploadFile();
  FocusNode focusNode = FocusNode();
  String? recordpath;
  File? audioFile;
  String? docFilePath;
  // XFile? imageFile;
  // List<XFile>?images;

  List<ImageObject> _imgObjs = [];

  // final ImagePicker picker = ImagePicker();
  //
  // Future<XFile> pickImage(ImageSource source) async {
  //   final XFile? galleryImage = await ImagePicker().pickImage(source: source);
  //   if (galleryImage != null) {
  //     imageFile = galleryImage;
  //     setState(() {});
  //     return imageFile!;
  //   } else {
  //     return XFile("");
  //   }
  //   // return videoFIle!;
  // }

  List icone = [
    Icons.video_call,
  ];
  var category = "1";
  var selected = "বড় প্রকল্প সমূহ";
  // List<Media> mediaList = [];

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
  Color color = Colors.grey;
  Color color1 = Colors.grey;
  // Color color2 = const Color(0xffFAFAFA);
  var enable = false;
  @override
  void initState() {
    // focusNode.addListener(onFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      Provider.of<AddLinkControllar>(context, listen: false)
          .changeColor(Colors.grey);
      Provider.of<AddLinkControllar>(context, listen: false)
          .changContact(profile.profile!.msg!.userData!.phone);
    });
    // loding();
    requestPermission(Permission.manageExternalStorage);

    // TODO: implement initState
    super.initState();
  }

  // void onFocusChange() {
  //   // Check if the TextField has focus
  //   if (focusNode.hasFocus) {
  //     // TextField is tapped, show the keyboard
  //     FocusScope.of(context).requestFocus(focusNode);
  //   } else {
  //     // TextField lost focus, hide the keyboard
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   controllar =  Provider.of<AddLinkControllar>(context,listen: false);
  // }

  List <String> imageName = [];

  @override
  void dispose() {
    // focusNode.removeListener(onFocusChange);
    // focusNode.dispose();
    print("dispos data");

     final controllerdis = Provider.of<AddLinkControllar>(context, listen: false);
    controllerdis.linkTitleController.clear();
    print("dispos data2");
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddLinkControllar>(context, listen: true);
    final controller2 = Provider.of<MyLinkContrllar>(context, listen: false);
    final categoryController =
        Provider.of<CategoricContrllar>(context, listen: true);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
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
            SizedBox(
              height: 20.h,
            ),
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
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 25.w,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: Text('লিংক যুক্ত করুন',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.sp,
                            fontFamily: 'IrabotiMJ')),
                  ),
                  // ListTile(
                  //   contentPadding:const EdgeInsets.only(right: 50),
                  //   leading :IconButton(onPressed: (){
                  //     Navigator.pop(context);
                  //   }, icon: Icon(Icons.arrow_back_ios,size: 28),),
                  //
                  //   title: Center(
                  //     child: Text(
                  //         'প্রস্তাবনা পাঠান',
                  //         style: TextStyle(
                  //             color: Colors.red,
                  //             fontSize: 18,
                  //             fontFamily: 'IrabotiMJ'
                  //         )
                  //     ),
                  //   ),
                  //
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10).r,
                    child: Container(
                      // height: size.height*0.85,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16).w,
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('প্রয়োজনীয় তথ্যগুলো সংযুক্ত করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.sp,
                                    fontFamily: 'IrabotiMJ')),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15).r,
                            child: Text('Categories',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 50.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5).w,
                                  color: const Color(0xffFAFAFA),
                                  border: Border.all(color: Colors.grey)),
                              child: DropdownSearch<String>(
                                selectedItem: selected,
                                popupProps: const PopupProps.menu(),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    textAlign: TextAlign.left,
                                    dropdownSearchDecoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(12).r,
                                        border: InputBorder.none)),
                                items: categoryController.catagoriclist.msg!
                                    .map((e) => e.catName!)
                                    .toList(),
                                onChanged: (value) {
                                  for (var i = 0;
                                  i <
                                      categoryController
                                          .catagoriclist.msg!.length;
                                  i++) {
                                    if (categoryController
                                        .catagoriclist.msg![i].catName ==
                                        value) {
                                      setState(() {
                                        category = categoryController
                                            .catagoriclist.msg![i].catId!;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15).r,
                            child: Text('Link Title',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15).r,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              //  focusNode: focusNode,
                              autofocus: false,
                              controller: controller.linkTitleController,
                              maxLines: 20,
                              minLines: 3,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff3E4040)),
                              decoration: InputDecoration(
                                hintText: 'Put Your Title Here...',
                                hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff3E4040)),
                                filled: true,
                                fillColor: const Color(0xffFAFAFA),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10).w,
                                    borderSide:
                                    const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10).w,
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.w)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15).r,
                            child: Text('Descriptions',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: controller.descriptionController,
                              keyboardType: TextInputType.text,
                              maxLines: 50,
                              minLines: 8,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff3E4040)),
                              decoration: InputDecoration(
                                hintText:
                                'Write some details about your projects here...',
                                hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff3E4040)),
                                filled: true,
                                fillColor: const Color(0xffFAFAFA),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10).w,
                                    borderSide:
                                    const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.w)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('ছবি/ভিডিও/অডিও যুক্ত করুন',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.sp,
                                    fontFamily: 'IrabotiMJ')),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(
                            height: 3.h,
                            thickness: 1.5,
                            endIndent: 10,
                            indent: 10,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var file =
                                      await controller.picVideoFIle();
                                      if (file != null) {
                                        var joinpath = join.basename(file.path);
                                        var check = await fileUpload
                                            .uploaddile(file.path);
                                        if (check != null) {
                                          color = Colors.red;
                                          //print(color);
                                          setState(() {});
                                        }
                                        // final uint8list = await VideoThumbnail.thumbnailData(
                                        //   video: file.path,
                                        //   imageFormat: ImageFormat.JPEG,
                                        //   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                        //   quality: 25,
                                        // );
                                        print("DDDD>>$joinpath");
                                      }
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5).w,
                                          color: Color(0xffFAFAFA),
                                          border: Border.all(color: color)),
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
                                          child: const Icon(
                                            Icons.add,
                                            size: 22,
                                            color: Colors.white,
                                          )))
                                ],
                              ),



                              InkWell(
                                onTap: () async {
                                  List<ImageObject> objects = [];

                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImagePickerScreen(),
                                    ),
                                  ).then((value) {
                                    if (value != null) {
                                      objects.addAll(value);

                                      if (objects.isNotEmpty) {
                                        List<String> data = [];
                                        for (var a in objects) {
                                          print(a.originalPath);
                                          fileUpload.uploaddile(a.originalPath).then((value) {
                                            if (value != null) {
                                              color1 = Colors.red;
                                              setState(() {});
                                            }
                                          });

                                          setState(() {
                                            data.add(a.originalPath);
                                            imageName.add('\"${join.basename(a.originalPath)}\"');
                                          });
                                        }
                                        print("Image Data$data");

                                        print("Image Data${objects[0].originalPath}");
                                      }
                                    }
                                  });
                                },

                                child: Stack(
                                  alignment: Alignment.topRight,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xffFAFAFA),
                                          border: Border.all(color: color1)),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/camera.svg",
                                          color: const Color(0xffC6C6C6),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                        right: -12,
                                        top: -5,
                                        child: CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.add,
                                              size: 22,
                                              color: Colors.white,
                                            )))
                                  ],
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
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: const Color(0xffFAFAFA),
                                          border: Border.all(
                                              color: controller.color)),
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
                                          child: Icon(
                                            Icons.add,
                                            size: 22,
                                            color: Colors.white,
                                          )))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('Contact Number',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  enable = !enable;
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text('পরিবর্তন করুন',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: controller.contactNumberController,
                              keyboardType: TextInputType.text,
                              enabled: enable,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: enable
                                      ? const Color(0xff3E4040)
                                      : Colors.grey),
                              decoration: InputDecoration(
                                hintText: 'Put your number here',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xff3E4040)),
                                filled: true,
                                fillColor: const Color(0xffFAFAFA),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              await controller
                                  .createLink(category,imageName)
                                  .then((value) async {
                                await controller2.getMyLink();
                                Navigator.pop(context);
                              });
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                height: 41,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(51),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text('সাবমিট',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'IrabotiMJ')),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
        });
  }
  //  openshowDialog(BuildContext context){
  //
  //   print("ddddddddddd sssssss");
  //
  //   var size=MediaQuery.of(context).size;
  //   // final controllerrr = Provider.of<AddLinkControllar>(context, listen: true);
  //   showDialog(
  //       context: context,
  //
  //       builder: ( BuildContext context){
  //     return AlertDialog(
  //       content:  Container(
  //         width: size.width,
  //         decoration: const BoxDecoration(color: Colors.white,
  //
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const SizedBox(
  //               height: 25,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 InkWell(
  //                   onTap: ()async {
  //
  //                    // pickImage(ImageSource.gallery);
  //                    //  List<XFile>? images = await picker.pickMultiImage();
  //                     print("Imaaaaaa$images");
  //                     if(images !=null)
  //                     {
  //                       var check =  await Provider.of<AddLinkControllar>(context, listen: false).uploadImage(images);
  //                       if (check != null) {
  //                         color1 = Colors.red;
  //                         print("Imaaaaaa$images");
  //                       }
  //                     }
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     decoration: const BoxDecoration(
  //                         color: Color(0xffE51D20),
  //                         borderRadius:
  //                         BorderRadius.all(Radius.circular(8))),
  //                     width: size.width * 0.30,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(10.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           CircleAvatar(
  //                               backgroundColor: Color(0xffB50003),
  //                               radius: 22,
  //                               child: SvgPicture.asset(
  //                                   "assets/gallarypic.svg")),
  //                           const Text("গ্যালারী",
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 12,
  //                                 fontFamily: 'IrabotiMJ',
  //                               ))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     pickImage(ImageSource.camera);
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: Color(0xffE51D20),
  //                         borderRadius:
  //                         BorderRadius.all(Radius.circular(8))),
  //                     width: size.width * 0.30,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(10.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           CircleAvatar(
  //                               backgroundColor: Color(0xffB50003),
  //                               radius: 22,
  //                               child: SvgPicture.asset(
  //                                   "assets/propiccamera.svg")),
  //                           Text("ক্যামেরা",
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 12,
  //                                 fontFamily: 'IrabotiMJ',
  //                               ))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  // void openImagePicker(BuildContext context) {
  //   // openCamera(onCapture: (image){
  //   //   setState(()=> mediaList = [image]);
  //   // });
  //   final controller = Provider.of<AddLinkControllar>(context, listen: false);
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return MediaPicker(
  //           mediaList:
  //               mediaList, //let MediaPicker know which medias are already selected by passing the previous mediaList
  //           onPick: (selectedList) async {
  //             var check = await controller.uploadImage(selectedList);
  //
  //             if (check != null) {
  //               color1 = Colors.red;
  //             }
  //             Navigator.pop(context);
  //           },
  //           onCancel: () => print('Canceled'),
  //           mediaCount: MediaCount.multiple,
  //           mediaType: MediaType.image,
  //           decoration: PickerDecoration(
  //             loadingWidget: Shimmer.fromColors(
  //               baseColor: Colors.red,
  //               highlightColor: Colors.yellow,
  //               child: const SizedBox(
  //                 width: 200.0,
  //                 height: 100.0,
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
