import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gim/controllers/orderController.dart';
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



  OrderController _order = Get.put(OrderController());

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
          body: Obx(
            () {
              return Stack(
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
                            controller: _order.phone,
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
                                  items: _order.items_cnt
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
                                  value: _order.selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _order.selectedValue = value as String;
                                      _order.checkFull();
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
                                  items: _order.items_dep
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
                                  value: _order.selectedValue2,
                                  onChanged: (value) {
                                    setState(() {
                                      _order.selectedValue2 = value as String;
                                      _order.checkFull();
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
                                  itemCount: _order.imagefiles?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: (() {
                                          setState(() {
                                            _order.imagefiles?.removeAt(index);
                                            _order.count = (_order.count! - 1);
                                            _order.checkFull();
                                          });


                                        }),
                                        child: Image.file(
                                            File(_order.imagefiles![index].path)));
                                  },
                                )),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                              //  color: Color.fromARGB(255, 172, 42, 85),
                                child: const Text(
                                  "Select From Gallery",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_order.count! <= 2) {


                                      _order.openImages();
                                      _order.checkFull();

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
                                  setState(() {

                                  });
                                  debugPrint("Button clicked!");
                                },
                              ),
                              TextButton(
                              //  color: Color.fromARGB(255, 172, 42, 85),
                                child: const Text(
                                  "Take From Camira",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_order.count! <= 2) {
                                    _order.loadCamera();
                                    _order.checkFull();
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
                                visible: _order.isFull.value,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      //maximumSize: Size(320.0, 70.0),
                                      //minimumSize: Size(320.0, 70.0),
                                      primary: Color.fromARGB(161, 214, 4, 4),
                                      shape: StadiumBorder(),
                                    ),
                                    onPressed: () {

                                      _order.sendOrder();
                                    },
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
              );
            }
          ),
        ),
      ),
    );
  }


}