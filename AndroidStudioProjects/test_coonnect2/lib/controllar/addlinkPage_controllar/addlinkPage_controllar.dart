
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'dart:io';
import 'package:path/path.dart' as join1;

import '../../Const/const.dart';
import '../../network/addlink_repo/addlink_repo.dart';
import 'package:http/http.dart' as http;

class AddLinkControllar extends ChangeNotifier{
  var box=Hive.box("login");
Color color = Colors.grey;

changeColor(Color c){
  color = c;
  print("colorChanges");
  notifyListeners();
 // notifyListeners();
 // notifyListeners();
}

  TextEditingController linkTitleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController contactNumberController=TextEditingController();

  changContact(number){
    contactNumberController.text = number;
    notifyListeners();
  }

  changTitle(number){
    linkTitleController.text = number;
    notifyListeners();
  }
  changDesc(number){
    descriptionController.text = number;
    notifyListeners();
  }
  AllLinkRepository allLinkRepository=AllLinkRepository();
  XFile? videoFIle;
  XFile? audioFile;
  String? audio;
  String? video;
  List<String> imageList=[];

  changeAudio(String path){
audio = path;
notifyListeners();
print(audio);
  }
  Future<XFile?>picVideoFIle()async{
    final XFile? galleryVideo =
    await ImagePicker().pickVideo(source: ImageSource.camera);

    if(galleryVideo!=null){

        videoFIle = galleryVideo;

        video = join1.basename(videoFIle!.path);
        notifyListeners();
        print(video);
        return videoFIle!;
    }
    else{
      return XFile("");
    }
    // return videoFIle!;
  }

 Future createLink(String category,List<String> imageList)async{
    await allLinkRepository.addLinkRepo(linkTitleController.text, descriptionController.text, box.get("userid"), contactNumberController.text, category, imageList, audio??"", video??"").then((value){
      linkTitleController.clear();
      descriptionController.clear();
      contactNumberController.clear();
      notifyListeners();

    });
  }
  Future updateLink({
    required String category,
    required String jobId,
    required  List<String> imageList


  })async{

    await allLinkRepository.updateJob(contactNumber:contactNumberController.text, jobTiltle: linkTitleController.text,connectId: jobId, desc: descriptionController.text, audio: audio??"", video: video??"", image: imageList, category: category).then((value){
      linkTitleController.clear();
      descriptionController.clear();
      contactNumberController.clear();
      notifyListeners();

    });

  }
  Future applyLink({required String category,
    required String  time,
    required String jobid,
    required String ownerId,
    required String note,
    required List<String> imageName

  })async{
    await allLinkRepository.jobApply(jobid: jobid, time: time, ownerId: ownerId, note: note, audio: audio??"", video: video??"", images: imageName);
  }

  Future<bool?> uploadImage(List<String> mediaList) async {
    // imageList.clear();
    // notifyListeners();
    print(mediaList.length);
    for(int a=0;  a< 2; a++) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$BaseUrl/uploader/up/'));

      print("imagessss0${a}");

      // String fileDir = join1.dirname(a);
      //
      // final newPath = join1.join(fileDir,
      //     join1.basename(a).replaceAll(" ", "_"));
      //
      //
      //
      // var image1 = await moveFile(File(a), newPath);
      request.files.add(await http.MultipartFile.fromPath('file', mediaList[a]));

      var image = join1.basename(mediaList[a]);

      print(image);

      imageList.add('\"$image\"');
      notifyListeners();
      print(request.files);
      print("imaglist-----" + imageList.toString());

      notifyListeners();
      http.StreamedResponse response = await request.send();
      var responsedata = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        var json = jsonDecode(responsedata.body);
        if (json['error'] == 0) {

          Fluttertoast.showToast(
              msg: "Upload Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          notifyListeners();
          return true;
        } else {
          print(json['msg'] + "msgggg");
          Fluttertoast.showToast(
              msg: json['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          notifyListeners();
          return false;
        }

      } else {
        print(responsedata.body);
        notifyListeners();
        return false;
      }
    }
    return null;
  }


  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}