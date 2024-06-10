
import 'dart:convert';

import 'package:http/http.dart'as http;

import '../../Const/const.dart';
import '../../model/categoric_model.dart';


class CategoricRepository{

  Future<CategoricModel?> categoricRepo()async{

    try{
      var responce=await http.get(Uri.parse("${BaseUrl}/job/catlisting"));
      var datadeco=await jsonDecode(responce.body);
      if(datadeco["error"]==0){
        return categoricModelFromJson(responce.body);
      }

    }catch(e,s){
      print(e);
    print(s);
    }

  }
}