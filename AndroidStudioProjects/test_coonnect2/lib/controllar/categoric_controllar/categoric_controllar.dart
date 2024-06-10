

import 'package:flutter/cupertino.dart';

import '../../model/categoric_model.dart';
import '../../network/categoric_repo/categoric.dart';

class  CategoricContrllar extends ChangeNotifier{

  var loder =false;

  var catagoriclist= CategoricModel();

  CategoricRepository categoricRepository=CategoricRepository();

  Future getCategoric()async{

    var network=await categoricRepository.categoricRepo();
    if(network !=null){
      catagoriclist= network;
      notifyListeners();
    }


  }



}