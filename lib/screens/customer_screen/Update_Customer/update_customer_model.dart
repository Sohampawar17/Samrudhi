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
  List<String> visitType=[""];
  String selectedVisitType = "";
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
  bool isTimerRunning = false;

  initialise(BuildContext context,String id) async {
    setBusy(true);
     visitType=await AddVisitServices().fetchVisitType();
     if(id!=""){
      customerData = await AddCustomerServices().getCustomer(id) ?? CreateCustomer();
      comments=await UpdateCustomerService().fetchComments(id);
      orders=await UpdateCustomerService().fetchCustomerOrder(id);
      filterOrders=orders;
    }
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

  void initTimerOperation(BuildContext context) {
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

    // Listen to app lifecycle changes
    SystemChannels.lifecycle.setMessageHandler((msg) {
      // On AppLifecycleState: paused
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          // Pause the timer
          countdownTimer?.pause(countdownSeconds);
        }
      }

      // On AppLifecycleState: resumed
      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          // Resume the timer
          countdownTimer?.resume();
        }
      }
      return Future(() => null);
    });

    // Start the timer
    isTimerRunning = true;
    countdownTimer?.start();

    // Handle any view-specific logic
    onStartTimerClicked(context);
  }

  void stopTimer() {
    isTimerRunning = false;
    countdownTimer?.stop();
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
