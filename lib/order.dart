import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';

class myOrder extends StatefulWidget {
  const myOrder({Key? key}) : super(key: key);
  @override
  _myOrderState createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {
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
  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];
  //final ImagePicker _picker = ImagePicker();
  //final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  //File photofile = File(photo!.path);
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image
  int? count;
  TextEditingController phone = TextEditingController();
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      //if (ListView.builder(itemCount: imagefiles.length)==3)
      if (pickedfiles != null) {
        imagefiles = [pickedfiles] + imagefiles;
        count = imagefiles.length;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  void initState() {
    super.initState();
    count = imagefiles.length;
  }

  loadCamera() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      //if (ListView.builder(itemCount: imagefiles.length)==3)
      if (pickedfiles != null) {
        imagefiles = [pickedfiles] + imagefiles;
        count = imagefiles.length;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
    // cameras = await availableCameras();
    // if (cameras != null) {
    //   controller = CameraController(cameras![0], ResolutionPreset.max);
    //   //cameras[0] = first camera, change to 1 to another camera
    //   controller!.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});
    //   });
    // } else {
    //   print("NO any camera found");
    // }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/order.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Text(
                      'Report filling form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 8.8,
                              color: Color.fromARGB(125, 0, 0, 255),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      TextField(
                        controller: phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          //contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                          fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                          filled: true,
                          labelText: 'Your Phone',
                          hintText: '07XXXXXXXX',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 226, 12, 12),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(height: 0.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 22,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' Select Country',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: items_cnt
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  checkFull();
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_double_arrow_down_sharp,
                              ),
                              iconSize: 22,
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: MediaQuery.of(context).size.width /
                                  1.22, //322,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Color.fromARGB(255, 36, 4, 168),
                              ),
                              buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 300,
                              dropdownWidth: MediaQuery.of(context).size.width /
                                  1.22, //322,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color.fromARGB(255, 36, 4, 168),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 7,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
                                  Icon(
                                    Icons.list,
                                    size: 22,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' Select Department',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: items_dep
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue2,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue2 = value as String;
                                  checkFull();
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_double_arrow_down_sharp,
                              ),
                              iconSize: 22,
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: MediaQuery.of(context).size.width /
                                  1.22, //322,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Color.fromARGB(255, 36, 4, 168),
                              ),
                              buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 300,
                              dropdownWidth: MediaQuery.of(context).size.width /
                                  1.22, //322,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color.fromARGB(255, 36, 4, 168),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 7,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        child: Container(
                            height: 150.0,
                            width:
                                MediaQuery.of(context).size.width / 1.22, //322,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imagefiles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: (() {
                                      imagefiles.removeAt(index);
                                      count = (count! - 1);
                                      checkFull();
                                      setState(() {});
                                    }),
                                    child: Image.file(
                                        File(imagefiles[index].path)));
                              },
                            )),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            color: Color.fromARGB(255, 172, 42, 85),
                            child: const Text(
                              "Select From Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (count! <= 2) {
                                openImages();
                                checkFull();
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "It is not allowed in more than three pictures",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              debugPrint("Button clicked!");
                            },
                          ),
                          RaisedButton(
                            color: Color.fromARGB(255, 172, 42, 85),
                            child: const Text(
                              "Take From Camira",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (count! <= 2) {
                                loadCamera();
                                checkFull();
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "It is not allowed in more than three pictures",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: isFull,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  //maximumSize: Size(320.0, 70.0),
                                  //minimumSize: Size(320.0, 70.0),
                                  primary: Color.fromARGB(161, 214, 4, 4),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Send Now  ',
                                      style: TextStyle(fontSize: 30.0),
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: Color.fromARGB(255, 124, 255, 189),
                                      size: 30.0,
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isFull = false;
  checkFull() {
    setState(() {
      if (phone.text.isNotEmpty &&
          selectedValue!.isNotEmpty &&
          selectedValue2!.isNotEmpty &&
          imagefiles.length > 0) {
        isFull = true;
      } else {
        isFull = false;
      }
    });
  }
}
