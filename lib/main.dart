import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocation/router.locator.dart';
import 'package:geolocation/screens/home_screen/home_page.dart';
import 'package:geolocation/screens/sales_force/route_assignment_form.dart';
import 'package:geolocation/screens/sales_force/route_creation_form.dart';
import 'package:geolocation/screens/sales_force/routes_process_screen.dart';
import 'package:geolocation/screens/splash_screen/splash_screen.dart';
import 'package:stacked_services/stacked_services.dart';
import 'router.router.dart';

// @pragma('vm:entry-point')
// Future<void> syncData() async {
//   Logger().i('sync data');
//   GeolocationService geolocationService = GeolocationService();
//   try {
//     Position? position = await geolocationService.determinePosition();
//     if (position != null) {
//       bool res = await GeolocationService().employeeLocation(
//           position.longitude.toString(), position.latitude.toString(),
//           '216556');
//       if (res) {
//         Logger().i('date is sending running');
//       }
//     } else {
//       Logger().i('service got error while send data');
//     }
//   } catch (e) {
//     // Fluttertoast.showToast(msg: '$e');
//     Logger().e(e);
//   }
// }
//
// @pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case 'simplePeriodic1HourTask':
//         syncData();
//         break;
//     }
//     return Future.value(true);
//   });
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // colorScheme: lightScheme,
            // extensions: [lightCustomColors],
              primarySwatch: Colors.green
          ),

          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          home:  HomePage(),
        );
      }

  }





