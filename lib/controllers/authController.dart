
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class AuthController extends GetxController{

 TextEditingController fullName = TextEditingController();
 TextEditingController phoneNumber = TextEditingController();
 TextEditingController nationalNumber = TextEditingController();


 TextEditingController otp = TextEditingController();

 bool check(){

  if(fullName.text.isNotEmpty && phoneNumber.text.length == 10 && nationalNumber.text.length>=10 ){

   return true;

  }else{

   return false;
  }

 }



 ///Log in and send a message to the user's phone from this function
   Future loginUser() async{


  FirebaseAuth _auth = FirebaseAuth.instance;

  _auth.verifyPhoneNumber(codeAutoRetrievalTimeout:( String v){
   print(v);
  },
   phoneNumber: "+962${phoneNumber.text}",
   timeout: Duration(seconds: 60),

   verificationCompleted: (AuthCredential credential) async{

   },

   verificationFailed: (FirebaseAuthException exception){
    Get.snackbar('عذرا', 'هناك مشكلة في الدخول الرجاء المواحلة بعد ساعة',snackPosition: SnackPosition.BOTTOM);
    print(exception);
   },
   codeSent: (String? verificationId, [int? forceResendingToken]){
    codeSentDialog(codeController: otp,auth: _auth,verificationId: verificationId);
   },
   //codeAutoRetrievalTimeout: null
  );
 }


 ///If a message is sent to the user's phone, a dialog appears for the user to enter the code
  codeSentDialog({codeController, verificationId,auth}){

  Get.defaultDialog(
   title:"ادخل رمز التأكد" ,
   content: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
     TextField(
      controller: codeController,
     ),
    ],
   ),
   actions: <Widget>[
    TextButton(
     child: Text("تأكيد"),
    // textColor: Colors.white,
    // color: Colors.blue,
     onPressed: () async{

      final code = codeController.text.trim();

      //send SMS with code on user's phone
      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

      UserCredential result = await auth.signInWithCredential(credential);

      User? user = result.user;
      SharedPreferences _sharedPreferences =  await SharedPreferences.getInstance();

      if(user != null){


       //So that he can enter the Home screen
       // and not return to the login screen if he has already logged in
       _sharedPreferences.setString('islogin', 'done');

       //The user's phone number and name are saved
       // in order to store them when performing any operation within the app
       print('the phoneNumber = ${user.phoneNumber}');
       _sharedPreferences.setString('phone' , '${user.phoneNumber}');
      // _sharedPreferences.setString('name' , '${AuthUtility.nameList[AuthUtility.phoneList.indexWhere((v)=>v==user.phoneNumber,)]}');

       print('${_sharedPreferences.getString('islogin')}');

       //route to Home screen without returning
       Get.offAll(Home());

      }else{
       print("Error");
      }
     },
    )
   ],

  );

 }


// Future register()async{
 //
 //  if(check()){
 //
 //   otpDialog();
 //
 //
 //  }
 //
 // }
 //
 //
 // void otpDialog(){
 //
 //  TextEditingController otp = TextEditingController();
 //
 //  Get.dialog(
 //   Column(
 //    children: [
 //
 //     Expanded(
 //       child: TextField(
 //        controller: otp,
 //        keyboardType: TextInputType.number,
 //        decoration: InputDecoration(
 //         hintText: "Insert OTP here"
 //        ),
 //       ),
 //     ),
 //
 //    ],
 //   )
 //  );
 //
 // }



}