import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/services/login_services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../router.router.dart';

class LoginViewModel extends BaseViewModel {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController urlController = TextEditingController()..text = 'https://mobilecrm.erpdata.in';
  TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool obscurePassword = true;
  bool isloading = false;

  initialise() {}

  void loginwithUsernamePassword(BuildContext context) async {
    isloading = true;
    notifyListeners();
    baseurl=urlController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    bool res = await loginservices().login(baseurl,username, password);
    isloading = false;
    notifyListeners();
    if (res) {
      if (context.mounted) {
        Navigator.popAndPushNamed(context, Routes.homePage);
      }
    } else {
      Logger().i('invalid credential');
    //   Fluttertoast.showToast(
    //       msg: "Invalid Credentials",
    //       toastLength: Toast.LENGTH_LONG,
    //       backgroundColor: Colors.white,
    //       textColor: Colors.black,
    //       fontSize: 16.0);
    }
  }

  String? validateUsername(username) {
    if (username.toString().isEmpty) {
      return "Enter a valid username";
    }
    return null;
  }

  String? validatePassword(password) {
    if (password.toString().isEmpty) {
      return "Enter a Password";
    }
    return null;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
