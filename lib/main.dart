import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/services.dart';
import 'package:geolocation/screens/splash_screen/splash_screen.dart';
import 'package:geolocation/themes/color_schemes.g.dart';
import 'package:geolocation/themes/custom_color.g.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'router.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Permission.location.isDenied.then((value) {
    if (value) {
      Permission.location.request();
    }
  });

  runApp(const MyApp());
}
//
// Future<void> initializeServices() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//       iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//           onStart: onStart, isForegroundMode: true, autoStart: false));
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   Homeviewmodel model = Homeviewmodel();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) async {
//       service.setAsForegroundService();
//       await model.locationbackgroundbutton();
//     });
//
//     service.on('setAsBackground').listen((event) async {
//       service.setAsBackgroundService();
//       await model.locationbackgroundbutton();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   Timer.periodic(const Duration(seconds: 2), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         await model.locationbackgroundbutton();
//         service.setForegroundNotificationInfo(
//             title: 'Location Updated',
//             content: 'Updated At ${DateTime.timestamp()}');
//       }
//     }
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          home: const SplashScreen(),
        );
      },
    );
  }
}
