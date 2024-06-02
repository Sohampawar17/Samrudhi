
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation/constants.dart';
import 'package:geolocation/services/login_services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../router.router.dart';

class LoginViewModel extends BaseViewModel {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController urlController = TextEditingController()..text = 'http://devsamruddhi.erpdata.in';
  TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool obscurePassword = true;
  bool isLoading = false;
  bool isDemoLoading = false;
  initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      usernameController.text = prefs.getString('username') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  void loginwithUsernamePassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    baseurl=urlController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    bool res = await LoginServices().login(baseurl,username, password);
    isLoading = false;
    notifyListeners();
    if (res) {
      if (context.mounted) {
        Navigator.popAndPushNamed(context, Routes.homePage);
      }
    } else {
      Logger().i('invalid credential');
      Fluttertoast.showToast(
          msg: "Invalid Credentials",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
  bool rememberMe = false;
  void changeRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }
  void loginWithDemoUser(BuildContext context) async {
    isDemoLoading = true;
    notifyListeners();
    baseurl="https://mobilecrm.erpdata.in";
    String username = 'demo@erpdata.in';
    String password = 'admin@123';
    bool res = await LoginServices().login(baseurl,username, password);
    isDemoLoading = false;
    notifyListeners();
    if (res) {
      if (rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', usernameController.text);
        await prefs.setString('password', passwordController.text);
        await prefs.setBool('rememberMe', true);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('username');
        await prefs.remove('password');
        await prefs.setBool('rememberMe', false);
      }
      if (context.mounted) {
        Navigator.popAndPushNamed(context, Routes.homePage);
      }
    } else {
      Logger().i('invalid credential');
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
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
