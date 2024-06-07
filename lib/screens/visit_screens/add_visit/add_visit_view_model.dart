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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../model/add_lead_model.dart';
import '../../../model/add_visit_model.dart';
import '../../../model/notes_list.dart';
import '../../../services/add_lead_services.dart';
import '../../../services/add_visit_services.dart';
import '../../../services/geolocation_services.dart';
import '../../../services/update_lead_services.dart';
import '../../../utility/countdown_timer.dart';

class AddVisitViewModel extends BaseViewModel{
  TextEditingController descriptonController=TextEditingController();

  AddVisitModel visitData =AddVisitModel();
  final formKey = GlobalKey<FormState>();
  List<String> visitType=[""];
  List<String> customer=[""];
  bool isEdit = false;
  String visitId = "";
  late SharedPreferences prefs;


  CountdownTimer? countdownTimer;
  int countdownSeconds = 0; // Initial countdown seconds
  bool isTimerRunning = false;
  static const String timerStartKey = 'timer_start';
  static const String timerElapsedKey = 'timer_elapsed';
  static const String enquiryKey = 'enquiryKey';
  static const String visitTypeKey = 'visitTypeKey';
  static const String visitIdKey = 'visitIdKey';
  String selectedVisitType = "";

  AddLeadModel leadData =AddLeadModel();
  bool res=false;
  List<NotesList> notes=[];

  initialise(BuildContext context, String leadId) async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();
    visitType=await AddVisitServices().fetchVisitType();
    leadData= await AddLeadServices().getlead(leadId) ?? AddLeadModel();
    notes=await UpdateLeadServices().getnotes(leadId);

   // customer=await AddVisitServices().fetchcustomer();
   //  if(visitId!=""){
   //    isEdit = true;
   //    visitdata =await AddVisitServices().getVisit(visitId) ?? AddVisitModel();
   //    descriptoncontroller.text=visitdata.description ?? "";
   //  }
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

  Future<void> restoreTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final timerStart = prefs.getInt(timerStartKey);
    final timerElapsed = prefs.getInt(timerElapsedKey);
    final leadId = prefs.getString(enquiryKey);
    final visitTypeString = prefs.getString(visitTypeKey);

    if (timerStart != null && timerElapsed != null   && leadId == leadData.name) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsed = (now - timerStart) ~/ 1000 + timerElapsed;
      countdownSeconds = elapsed;
      selectedVisitType = visitTypeString!;
      startTimer(countdownSeconds);

      notifyListeners();
    }
  }
  void setVisitType(String visitType){
    this.selectedVisitType =visitType;
    notifyListeners();
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
    await prefs.setString(enquiryKey, leadData.name!);
    await prefs.setString(visitTypeKey,selectedVisitType!);
  }

  Future<void> clearTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(timerStartKey);
    await prefs.remove(timerElapsedKey);
    await prefs.remove(enquiryKey);
    await prefs.remove(visitTypeKey);
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


  void onSavePressed() async {
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
                position.latitude, position.longitude) ??
                "";
        visitData.visitor = "Enquiry";
        visitData.enquiry = leadData.leadName;
        visitData.visitType = selectedVisitType;
        visitData.enquiryName= "${leadData.firstName} ${leadData.leadName}";
        visitData.requestType= leadData.customCustomRequestType;
        visitData.startLocation = formattedAddress;
        visitData.startLatitude = position.latitude.toString();
        visitData.startLongitude = position.longitude.toString();
        visitData.startLocation = formattedAddress;
        visitData.startTime =formatTime();
        visitId = await AddVisitServices().addVisit(visitData);
        await prefs.setString(visitIdKey,visitId);
        if(visitId.isNotEmpty){
          startTimer(countdownSeconds);
        }else{
          Fluttertoast.showToast(msg: 'Failed to upload data. Timer can not be started');
        }
        Logger().i(visitData.toJson());
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } finally {
       // setBusy(false);
      }

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
       setBusy(true);

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

           visitData.latitude = position.latitude.toString();
           visitData.longitude = position.longitude.toString();
           visitData.endLocation = formattedAddress;
           visitData.visitType = selectedVisitType;
           visitData.endTime = formatTime();
           visitData.endLatitude = position.latitude.toString();
           visitData.endLongitude = position.longitude.toString();
           visitData.description = descriptonController.text;
           visitData.name = visitId;
           await AddVisitServices().addVisit(visitData);
           await prefs.remove(visitIdKey);
         //  Navigator.popUntil(context, ModalRoute.withName(Routes.visitScreen));
         } catch (e) {
           Fluttertoast.showToast(msg: '$e');
         } finally {
           setBusy(false);
         }
       }
       setBusy(false);

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
    visitData.customer =expenseDate;
    notifyListeners();
  }

  void setdescription(String expenseDescription){
    descriptonController.text=expenseDescription;
    visitData.description =descriptonController.text;
    notifyListeners();
  }


  void seteleavetype(String? expenseType){
    visitData.visitType =expenseType;
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
    descriptonController.dispose();
    super.dispose();
  }
}