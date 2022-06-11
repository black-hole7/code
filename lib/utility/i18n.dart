import 'package:get/get.dart';

class Internationalize extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      "Registration":"New Registration",
      "Municipality":"Greater Irbid\nMunicipality",
      "report":"Apply Your Report",
      "Instructions":"Instructions",
      "Policies":"Policies"
    },
    'ar_DZ': {
   "Registration":"تسجيل جديد",
      "Municipality":"بلدية اربد \n الكبرى",
      "report":"ارسل تقريرك",
      "Instructions":"التعليمات",
      "Policies":"السياسات"
    }
  };
}