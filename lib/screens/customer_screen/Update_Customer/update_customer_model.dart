import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocation/model/comment_List_model.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:geolocation/services/update_customer_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_visit_model.dart';
import '../../../services/add_customer_services.dart';
import '../../../services/add_visit_services.dart';
import '../../../services/call_services.dart';
import '../../../services/geolocation_services.dart';
import '../../../utility/countdown_timer.dart';

class UpdateCustomerViewModel extends BaseViewModel{
  TextEditingController comment=TextEditingController();
  TextEditingController descriptonController=TextEditingController();
  CreateCustomer customerData=CreateCustomer();
  final CallsAndMessagesService service = CallsAndMessagesService();
  List<CommentList> comments=[];
  bool res=false;
  List<CustOrderList> orders = [];
  List<CustOrderList> filterOrders = [];
  late SharedPreferences prefs;

  List<String> visitType=[""];
  String selectedVisitType = "";
  bool isTimerRunning = false;
  static const String timerStartKey = 'timer_start';
  static const String timerElapsedKey = 'timer_elapsed';
  static const String customerKey = 'customerKey';
  static const String visitTypeKey = 'visitTypeKey';
  static const String visitIdKey = 'visitIdKey';

  List<String> status=[
  "Not Delivered",
  "Fully Delivered",
  "Partly Delivered",
  "Closed",
  "Not Applicable"
   ];

  AddVisitModel visitdata =AddVisitModel();
  final formKey = GlobalKey<FormState>();
  List<String> customer=[""];
  bool isEdit = false;
  String visitId = "";

  CountdownTimer? countdownTimer;
  int countdownSeconds = 0; // Initial countdown seconds


  initialise(BuildContext context,String id) async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();
    visitType=await AddVisitServices().fetchVisitType();
    customerData = await AddCustomerServices().getCustomer(id) ?? CreateCustomer();
     if(id!=""){
      comments=await UpdateCustomerService().fetchComments(id);
      orders=await UpdateCustomerService().fetchCustomerOrder(id);
      filterOrders=orders;
    }
    await restoreTimerState();

    // Listen to app lifecycle changes
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      print("msg $msg");
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          await saveTimerState();
          countdownTimer?.pause(countdownSeconds);
        }
      }

      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          await restoreTimerState();
          countdownTimer?.resume();
        }
      }
      return Future(() => null);
    });

    setBusy(false);
  }

  void addComment(String? id,dynamic content)async{

    if(id!.isNotEmpty){
      res=await UpdateCustomerService().addComment(id,content);}
    if(res){
      comments=await UpdateCustomerService().fetchComments(id);
    }
    comment.clear();
    notifyListeners();
  }

  Future<void> addFilter(String id,String status) async {
    filterOrders=await UpdateCustomerService().fetchFilterCustomerOrder(id,status);
    notifyListeners();
  }

  void setVisitType(String visitType){
    this.selectedVisitType =visitType;
    notifyListeners();
  }

  Future<void> restoreTimerState() async {

    final timerStart = prefs.getInt(timerStartKey);
    final timerElapsed = prefs.getInt(timerElapsedKey);
    final customerId = prefs.getString(customerKey);
    final visitTypeString = prefs.getString(visitTypeKey);

    if (timerStart != null && timerElapsed != null  && customerId == customerData.name) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsed = (now - timerStart) ~/ 1000 + timerElapsed;
      countdownSeconds = elapsed;
      selectedVisitType = visitTypeString!;

      startTimer(countdownSeconds);

      notifyListeners();
    }
  }

  void initTimerOperation(BuildContext context) {
    // Initialize timer callbacks
    startTimer(countdownSeconds);
  }


  void startTimer(int countdownseconds) {
    // Initialize timer callbacks
    countdownTimer = CountdownTimer(
      seconds: countdownSeconds,
      onTick: (seconds) {
        isTimerRunning = true;
        countdownSeconds = seconds;
        // Notify listeners about changes
        notifyListeners();
      },
      onFinished: () {
        stopTimer();
        // Handle countdown finished
      },
    );

    // Start the timer
    isTimerRunning = true;
    countdownTimer?.start();

    // Handle any view-specific logic
    //  onSavePressed();
  }

  Future<void> saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;

    await prefs.setInt(timerStartKey, now);
    await prefs.setInt(timerElapsedKey, countdownSeconds);
    await prefs.setString(customerKey, customerData.name!);
    await prefs.setString(visitTypeKey,selectedVisitType);
  }

  Future<void> clearTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(timerStartKey);
    await prefs.remove(timerElapsedKey);
    await prefs.remove(visitTypeKey);
    await prefs.remove(customerKey);
  }


  void stopTimer() {
    isTimerRunning = false;
    countdownTimer?.stop();
    clearTimerState();
    // Notify listeners about changes
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    countdownSeconds = 0;
    // Notify listeners about changes
    notifyListeners();
  }

  void onStartTimerClicked(BuildContext context) async {
    // setBusy(true);
      //bool res = false;
      Fluttertoast.showToast(msg: 'Fetching location. Wait for few seconds..');
      GeolocationService geolocationService = GeolocationService();
      try {
        Position? position = await geolocationService.determinePosition();

        if (position == null) {
          Fluttertoast.showToast(msg: 'Failed to get location');
          return setBusy(false);
        }

        Placemark? placemark = await geolocationService.getPlacemarks(position);
        if (placemark == null) {
          Fluttertoast.showToast(msg: 'Failed to get placemark');
          return setBusy(false);
        }

        String formattedAddress =
            await geolocationService.getAddressFromCoordinates(
                position.latitude, position.longitude) ?? "";
        visitdata.customer = customerData.name;
        visitdata.customerName = customerData.customerName;
        visitdata.visitType = selectedVisitType;
        visitdata.latitude = position.latitude.toString();
        visitdata.longitude = position.longitude.toString();
        visitdata.location = formattedAddress;
        visitdata.startLatitude = position.latitude.toString();
        visitdata.startLongitude = position.longitude.toString();
        visitdata.location = formattedAddress;
        visitdata.startTime =formatTime();

        visitId = await AddVisitServices().addVisit(visitdata);
        await prefs.setString(visitIdKey,visitId);
        if(visitId.isNotEmpty || visitId != null){
          startTimer(countdownSeconds);
        }else{
          Fluttertoast.showToast(msg: 'Failed to upload data. Timer can not be started');
        }
        Logger().i(visitdata.toJson());
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } finally {
        // setBusy(false);
      }

    //setBusy(false);
  }

  String formatTimer(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }



  void onVisitSubmit(BuildContext context) async {
    if(visitId.isEmpty) {
      visitId = prefs.getString(visitIdKey)!;
    }
    if(visitId.isNotEmpty) {
      print(visitId);
      setBusy(true);
        Logger().i(visitdata.toJson());
        //bool res = false;
        GeolocationService geolocationService = GeolocationService();
        try {
          Position? position = await geolocationService.determinePosition();

          if (position == null) {
            Fluttertoast.showToast(msg: 'Failed to get location');
            return setBusy(false);
          }

          Placemark? placemark = await geolocationService.getPlacemarks(
              position);
          if (placemark == null) {
            Fluttertoast.showToast(msg: 'Failed to get placemark');
            return setBusy(false);
          }

          String formattedAddress =
              await geolocationService.getAddressFromCoordinates(position.latitude, position.longitude) ?? "";

          visitdata.latitude = position.latitude.toString();
          visitdata.longitude = position.longitude.toString();
          visitdata.location = formattedAddress;
          visitdata.endTime = formatTime();
          visitdata.endLatitude = position.latitude.toString();
          visitdata.endLongitude = position.longitude.toString();
          visitdata.description = descriptonController.text;
          visitdata.name = visitId;
          await AddVisitServices().addVisit(visitdata);
          await prefs.remove(visitIdKey);
        //  Navigator.popUntil(context, ModalRoute.withName(Routes.visitScreen));
        } catch (e) {
          Fluttertoast.showToast(msg: '$e');
        } finally {
          setBusy(false);
        }
      setBusy(false);
    }else{
      Fluttertoast.showToast(msg: 'Existing details are not available.');

    }
  }

  String formatTime(){
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    return formattedTime;
  }

}

class CustOrderList {
  String? name;
  String? deliveryDate;
  double? roundedTotal;

  CustOrderList({this.name, this.deliveryDate, this.roundedTotal});

  CustOrderList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    deliveryDate = json['delivery_date'];
    roundedTotal = json['rounded_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['delivery_date'] = this.deliveryDate;
    data['rounded_total'] = this.roundedTotal;
    return data;
  }
}
