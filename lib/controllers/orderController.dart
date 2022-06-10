import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gim/controllers/authController.dart';
import 'package:gim/controllers/homeController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController{



  final ImagePicker imgpicker = ImagePicker();
  RxList imagefiles = [].obs ;
 // List<CameraDescription>? cameras; //list out the camera available
 // CameraController? controller; //controllers for camera
 // XFile? image; //for captured image
  int? count;
  TextEditingController phone = TextEditingController();
  TextEditingController note = TextEditingController();


  final List<String> items_cnt = [
    'لواء قصبة إربد - بدلية إربد الكبرى',
    'لواء قصبة إربد - بدلية غرب إربد',
    'لواء بني عبيد - بلدية إربد الكبرى',
    'لواء الكورة- بلدية دير أبو سعيد الجديدة',
    'لواء الكورة - بلدية برقش',
    'لواء الكورة -  بلدية رابية الكورة',
    'لواء الرمثا - بلدية الرمثا الجديدة',
    'لواء الرمثا - بلدية سهل حوران',
  ];
  final List<String> items_dep = [
    'إنارة الطريق',
    'تعبيد الطرق',
    'تمديدات المياه الصحية',
    'شبكة الصرف الصحي',
    'شبكات الكهرباء',
  ];
  String? selectedValue;
  String? selectedValue2;


  HomeController _controller =Get.put(HomeController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    count = imagefiles.length;

    savePhoneNumber();

  }

  savePhoneNumber()async{
    if(!_controller.isNotRegs.value){
      phone.text = (await FirebaseAuth.instance.currentUser?.phoneNumber)!;
    }
  }


  openImages(source) async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: source);


      if (pickedfiles != null) {
        imagefiles.add(File(pickedfiles.path));
        count = imagefiles.length;
        update();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }


  loadCamera() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      //if (ListView.builder(itemCount: imagefiles.length)==3)
      if (pickedfiles != null) {
        imagefiles.add(pickedfiles);
        count = imagefiles?.length;
        update();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }

  }

  RxBool isFull = false.obs;

  checkFull( bool isRegs) async{


    if (phone.text.isNotEmpty &&
          selectedValue!.isNotEmpty &&
          selectedValue2!.isNotEmpty &&
          imagefiles.isNotEmpty) {
        isFull.value = true;
      } else {
        isFull.value = false;
      }
      update();
  }




  Future<String> uploadFile(File _image , String orderId) async {
    Uuid uuid = Uuid();

   late Future<String>  url ;

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('orders/${orderId}/');

    UploadTask task =  storageReference.child('${uuid.v1()}').putFile(_image);

    await task.then((e) {

       url = e.ref.getDownloadURL();


    });

    return await url;

  }
   sendOrder()async {

     Uuid uuid = Uuid();

    String  _orderId = uuid.v4();


     List<String> images = await Future.wait(imagefiles.value.map((e)=>uploadFile(e,_orderId)));







   await  FirebaseFirestore.instance.collection('orders').doc(_orderId).set({

     "id":_orderId,
     "phone":phone.text,
     "country" :selectedValue,
     "department": selectedValue2,
     "images" : images,
     "note": note.text,
     "location" :"",
     "mac_address" :""
   }).then((value) => Get.snackbar("Successfull", "Your Order Sent !",snackPosition: SnackPosition.BOTTOM));



   }




   verifyPhoneNumber(){

    if(!_controller.isNotRegs.value){




    }else{
      sendOrder();
    }
   }
}