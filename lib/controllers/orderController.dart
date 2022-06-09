import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    count = imagefiles.length;
  }



  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);


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
  checkFull() {

      if (phone.text.isNotEmpty &&
          selectedValue!.isNotEmpty &&
          selectedValue2!.isNotEmpty &&
          imagefiles!.length > 0) {
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
     "note": "",
     "location" :"",
     "mac_address" :""
   });


     //    task.then((valueT) {
     //      valueT.ref.getDownloadURL().then((value) {
     //        FirebaseFirestore.instance.collection('binsNotes')
     //            .doc('${id}')
     //            .set({
     //          'adminName': _adminController.userName.value,
     //          'id': '${id}',
     //          'message': '${noteController.text}',
     //          'date': DateTime.now().toIso8601String(),
     //          'bin Number': '${qrCode.value}',
     //          'image': '${value.toString()}',
     //          'done': false
     //        });
     //
     //
     //
     // }

   }
}