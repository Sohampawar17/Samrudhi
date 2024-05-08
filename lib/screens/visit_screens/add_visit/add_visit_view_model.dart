import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocation/router.router.dart';
import 'package:geolocation/screens/visit_screens/visit_list/visit_list_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_visit_model.dart';
import '../../../services/add_visit_services.dart';
import '../../../services/geolocation_services.dart';
import '../../../utility/countdown_timer.dart';

class AddVisitViewModel extends BaseViewModel{
  TextEditingController descriptoncontroller=TextEditingController();

  AddVisitModel visitdata =AddVisitModel();
  final formKey = GlobalKey<FormState>();
  List<String> visitType=[""];
  List<String> customer=[""];
  bool isEdit = false;
  String visitId = "";

  CountdownTimer? countdownTimer;
  int countdownSeconds = 0; // Initial countdown seconds
  bool isTimerRunning = false;

  initialise(BuildContext context, String visitId) async {
    setBusy(true);
    visitType=await AddVisitServices().fetchVisitType();
    customer=await AddVisitServices().fetchcustomer();
    if(visitId!=""){
      isEdit = true;
      visitdata =await AddVisitServices().getVisit(visitId) ?? AddVisitModel();
      descriptoncontroller.text=visitdata.description ?? "";
    }
    setBusy(false);
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
    onSavePressed(context);
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


  void onSavePressed(BuildContext context) async {
   // setBusy(true);
    if (formKey.currentState!.validate()) {
      Logger().i(visitdata.toJson());
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
                position.latitude, position.longitude) ??
                "";
        visitdata.latitude = position.latitude.toString();
        visitdata.longitude = position.longitude.toString();
        visitdata.location = formattedAddress;
        visitdata.startLatitude = position.latitude.toString();
        visitdata.startLongitude = position.longitude.toString();
        visitdata.location = formattedAddress;
        visitdata.startTime =formatTime();

       visitId = await AddVisitServices().addVisit(visitdata);

       Logger().i(visitId);

      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } finally {
       // setBusy(false);
      }

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
       if (formKey.currentState!.validate()) {
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
               await geolocationService.getAddressFromCoordinates(
                   position.latitude, position.longitude) ??
                   "";
           visitdata.latitude = position.latitude.toString();
           visitdata.longitude = position.longitude.toString();
           visitdata.location = formattedAddress;
           visitdata.endTime = formatTime();
           visitdata.endLatitude = position.latitude.toString();
           visitdata.endLongitude = position.longitude.toString();
           visitdata.description = descriptoncontroller.text;
           visitdata.name = visitId;
           await AddVisitServices().addVisit(visitdata);
           Navigator.popUntil(context, ModalRoute.withName(Routes.visitScreen));
         } catch (e) {
           Fluttertoast.showToast(msg: '$e');
         } finally {
           setBusy(false);
         }
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



  void setVisitId(String? visitId){
   this.visitId =visitId!;
   notifyListeners();
  }


  void setcustomer(String? expenseDate){
    visitdata.customer =expenseDate;
    notifyListeners();
  }

  void setdescription(String expenseDescription){
    descriptoncontroller.text=expenseDescription;
    visitdata.description =descriptoncontroller.text;
    notifyListeners();
  }


  void seteleavetype(String? expenseType){
    visitdata.visitType =expenseType;
    notifyListeners();
  }

  ///validators
  String? validatedate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Select the date';
    }
    return null;
  }

  String? validateexpensetyepe(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select expense type';
    }
    return null;
  }

  String? validatedescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter description';
    }
    return null;
  }
  String? validateamount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter amount';
    }
    return null;
  }

  ///dispose controllers
  @override
  void dispose() {
    descriptoncontroller.dispose();
    super.dispose();
  }
}