

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../Const/const.dart';
import '../controllar/addlinkPage_controllar/addlinkPage_controllar.dart';
import '../network/fileUpload/upload.dart';
import 'package:path/path.dart' as join1;

class RecordExample extends StatefulWidget {
  const RecordExample({Key? key}) : super(key: key);

  @override
  State<RecordExample> createState() => _RecordExampleState();
}

class _RecordExampleState extends State<RecordExample> {
  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";
  Record? record;
  bool startRecord= false;
  UploadFile fileUpload=UploadFile();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    record!.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<AddLinkControllar>(context,listen: false);
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), topLeft: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),

                recordDuration !="00:00" ? const Text("Release To Sent, Swipe Stop Button",style: TextStyle(fontSize: 16,color:Color (0xff3E4040)),): Container(),
               const SizedBox(height: 22,),
                Text(recordDuration,style: const TextStyle(fontSize: 22,color: Colors.black),),
                const SizedBox(height: 10,),
                InkWell(
                    onTap: ()async{
                      if (await Record().hasPermission()) {

                        if(startRecord){
                          setState(() {
                            startRecord = false;
                            timer?.cancel();
                            timer = null;
                            recordDuration = "00:00";
                          });
                          var filePath= await record!.stop();

                          print(filePath);
                         controller.changeAudio(join1.basename(filePath!));
                          fileUpload.uploaddile(filePath);
                          controller.changeColor(Colors.red);
                          Navigator.pop(context);
                        }
                        else{
                          record = Record();
                          await record!.start(
                            path:
                            "${documentPath}audio_${DateTime.now().millisecondsSinceEpoch}.acc",
                            encoder: AudioEncoder.aacLc,
                            bitRate: 128000,
                            samplingRate: 44100,
                          ).then((value){
                            setState(() {
                              startRecord = true;
                            });
                          });
                          startTime = DateTime.now();
                          timer = Timer.periodic(const Duration(seconds: 1), (_) {
                            final minDur = DateTime.now().difference(startTime!).inMinutes;
                            final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
                            String min = minDur < 10 ? "0$minDur" : minDur.toString();
                            String sec = secDur < 10 ? "0$secDur" : secDur.toString();
                            setState(() {
                              recordDuration = "$min:$sec";
                            });
                          });

                          // widget.onRecordStart();
                        }}
                    },
                    child:
                    recordDuration !="00:00" ?  CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.red,
                        child: Center(
                            child: InkWell(
                              onTap: (){
                              //  Navigator.pop(context);
                              },
                                child: Text("Stop",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                        )
                    ): CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.red,
                      child: Center(
                          child: Text("Recod",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                      ),)
                )
              ],
            ),


          ),

        ],
      ),
    );
  }


}
