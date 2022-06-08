import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  // static Future AuthPhone({required String phoneNumber}) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+962${phoneNumber}',
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       Fluttertoast.showToast(msg: "Successful Auth");
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       Fluttertoast.showToast(msg: "$e");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  static Future loginUser({String? phoneController}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: (String v) {
        print(v);
      },
      phoneNumber: "+962$phoneController",
      timeout: Duration(seconds: 60),

      verificationCompleted: (AuthCredential credential) async {},

      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        Fluttertoast.showToast(msg: "Code Sent");
      },
      //codeAutoRetrievalTimeout: null
    );
  }
}
