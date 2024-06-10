import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart'as http;

import '../../Const/const.dart';
import '../../model/OtherLinkModel/OtherLinkModel.dart';
import '../../model/mylinkModel/mylinkModel.dart';

class MylinkRepository{

   Future<MyLinkModel?> myLinkRepo()async{
      var box = Hive.box('login');
      try{
         var responce=await http.get(Uri.parse("${BaseUrl}/user/usersjob/${box.get('userid')}"));
         var dataDecde=jsonDecode(responce.body);
         if(dataDecde["error"]==0)
         {
           // print("myLink>>>>>>${responce.body}");

            return myLinkModelFromJson(responce.body);
         }
         else{
            return null;
         }
      }catch(e,s){
         print(e);
         print(s);

         return null;
      }


   }


   Future<OtherLinkModel?> otherLinkRepo(id)async{
      var box = Hive.box('login');
      try{
         var responce=await http.get(Uri.parse("${BaseUrl}/user/usersjob/$id"));
         var dataDecde=jsonDecode(responce.body);
         if(dataDecde["error"]==0)
         {

            return otherLinkModelFromJson(responce.body);
         }
         else {
            return null;
         }
      }catch(e,s){

         print(e);
         print(s);
         return null;
      }


   }
}