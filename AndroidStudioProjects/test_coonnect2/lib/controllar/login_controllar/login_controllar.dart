

import 'package:flutter/cupertino.dart';

import '../../network/auth/login.dart';

class LoginControllar extends ChangeNotifier{

  bool passvisible=true;
  LoginRepository loginRepository=LoginRepository();

  TextEditingController emailControllar=TextEditingController();
  TextEditingController passwordControllar=TextEditingController();
  var loder=false;

   passwordVisivile(){

    passvisible=!passvisible;
    print('visibiliti $passvisible');
    notifyListeners();

  }

 Future getLogin(BuildContext context)async{
   loder= true;
   notifyListeners();
   await loginRepository.LoginRepo(emailControllar.text, passwordControllar.text,context).then((value) {
     emailControllar.clear();
     passwordControllar.clear();
     loder=false;
     notifyListeners();
   });


  }
}