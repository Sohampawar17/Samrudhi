import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';

Widget fullScreenLoader(
    {required bool loader,
    required Widget child,
    required BuildContext context}) {
  return Stack(
    children: [
      child,
      loader == true
          ? Container(
              height: getHeight(context),
              width: getWidth(context),
              color: Colors.white.withOpacity(1),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LOADING..',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.normal)),
                    SizedBox(height: 20,),
                  SpinKitFadingCircle(
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                    SizedBox(height: 20,),
                    Text('PLEASE WAIT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.normal)),
                  ],
                ),
              ),
            )
          : Container(),
    ],
  );
}
