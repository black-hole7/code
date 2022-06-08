// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class myHome extends StatefulWidget {
  const myHome({Key? key}) : super(key: key);

  @override
  _myHomeState createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/login.png',
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
                      'Greater Irbid\nMunicipality',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
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
                    top: MediaQuery.of(context).size.height * 0.4,
                    left: 35,
                    right: 35,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(
                                    MediaQuery.of(context).size.width / 1.7,
                                    50.0), //230, 50
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.7,
                                    50.0), //230, 50
                                primary: Color.fromARGB(255, 81, 13, 177),
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'New Registration ',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Icon(
                                    Icons.app_registration,
                                    color: Color.fromARGB(255, 124, 255, 189),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(
                                    MediaQuery.of(context).size.width / 3,
                                    50.0), //130
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width / 3,
                                    50.0), //130
                                primary: Color.fromARGB(255, 81, 13, 177),
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Icon(
                                    Icons.login,
                                    color: Color.fromARGB(255, 124, 255, 189),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(
                                    MediaQuery.of(context).size.width / 1.22,
                                    70.0),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.22,
                                    70.0),
                                primary: Color.fromARGB(161, 214, 4, 4),
                                shape: StadiumBorder(),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'order');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Apply Your Report  ',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  Icon(
                                    Icons.send_sharp,
                                    color: Color.fromARGB(255, 124, 255, 189),
                                    size: 30.0,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            //onPressed: () {
                            //Navigator.pushNamed(context, 'instructions');
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            child: Text(
                              'Instructions',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          TextButton(
                            //onPressed: () {
                            //Navigator.pushNamed(context, 'policies');
                            onPressed: () {
                              showAlertDialog2(context);
                            },
                            child: Text(
                              'Policies',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
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
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("How To Use"),
    content: SingleChildScrollView(
      // won't be scrollable
      child: Text(
          "- Click on the Submit a Report Now button to send it to the concerned authorities. In this case, you will have to enter your personal information each time.\n- Create an account for the first time to save your information so that you can submit your report immediately without entering your information every time."),
    ),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("The Politics:"),
    content: SingleChildScrollView(
      child: Text(
          '- Please note that all information sent by you, in addition to your personal information, will be kept confidential\n- The municipality has the right to see this information according to its powers\n- Any wrong information, you will be held responsible.'),
    ),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
