import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'controllers/authController.dart';

class myRegister extends StatefulWidget {
  const myRegister({Key? key}) : super(key: key);
  @override
  _myRegisterState createState() => _myRegisterState();
}

class _myRegisterState extends State<myRegister> {

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/register.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text("REGISTER"),
              elevation: null,
              backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [

                      ///full name
                      TextField(
                        controller: authController.fullName,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter Your Full Name',
                          fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 125, 135, 231),
                              )),
                        ),
                      ),
                      SizedBox(height: 35.0),
                      ///National Number
                      TextField(
                        controller: authController.nationalNumber,
                        maxLength: 11,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                          filled: true,
                          labelText: 'National Number',
                          hintText: 'Enter Your ID Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(height: 15.0),
                      ///phone number
                      TextField(
                        controller: authController.phoneNumber,
                        maxLength: 10,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                          filled: true,
                          labelText: 'Phone',
                          hintText: '7XXXXXXXX',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(height: 15.0),

                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [



                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(170.0, 90.0),
                                minimumSize: const Size(170.0, 60.0),
                                primary: Colors.black,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {

                                if(authController.check()){
                                authController.loginUser();}
                                else{
                                  Get.snackbar("Error", "Please fill all fields",snackPosition:SnackPosition.BOTTOM);
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('REGISTER'),
                                  Icon(
                                    Icons.content_paste_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 30.0),

                    ],
                  ),
                ),
              ),
              /*Visibility(
                  visible: visible,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CircularProgressIndicator()
                      )
                    ),*/
            ],
          ),
        ),
      ),
    );
  }
}

bool isNumber(String value) {
  if (value == null) {
    return true;
  }
  final n = num.tryParse(value);
  return n != null;
}
