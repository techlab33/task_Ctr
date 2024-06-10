

import 'package:flutter/cupertino.dart';

import '../../model/mylinkModel/mylinkModel.dart';
import '../../network/myLinkrepo/myLink.dart';

class  MyLinkContrllar extends ChangeNotifier{

  var loader =true;
  notifyListeners();
  MyLinkModel? mylinkList;

  MylinkRepository mylinkRepository=MylinkRepository();

  Future getMyLink()async{

    var network=await mylinkRepository.myLinkRepo();
    if(network !=null){
      mylinkList= network;
       loader =false;
      notifyListeners();
    }
    else{
      mylinkList = null;
      loader =false;
      notifyListeners();
    }


  }



}