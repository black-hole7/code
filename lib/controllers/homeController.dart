
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeController extends GetxController{


  RxBool notRegister = true.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isSign();
    isReg();
  }



  isSign()async{
       await  FirebaseAuth.instance.signOut();
 //   print();
  //  print( await FirebaseAuth.instance.currentUser?.phoneNumber);

    if(await FirebaseAuth.instance.currentUser?.uid != null){
      notRegister.value = false;
    }
    else{
      notRegister.value = true;
    }
  }


  RxBool isNotRegs = true.obs;


  isReg()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

   preferences.remove('reg');

    if(preferences.getBool("reg") != null){

      isNotRegs.value = false;
    }
    else{
      isNotRegs.value = true;
    }
  }
}