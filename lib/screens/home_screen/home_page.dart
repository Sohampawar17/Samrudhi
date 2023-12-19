import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/router.router.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/drawer.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Homeviewmodel>.reactive(
        viewModelBuilder: () => Homeviewmodel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title:  Text(model.dashboard.company ?? "",style: TextStyle(fontSize: 17),),
              ),
              drawer: myDrawer(context, (model.dashboard.empName ?? ""),
                  (model.user ?? ""), (model.dashboard.employeeImage ?? "")),
              body: fullScreenLoader(
                loader: model.isBusy,
                context: context,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                           decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),

                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model.greeting ?? ""}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${model.dashboard.empName.toString().toUpperCase()},",overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               Text( model.dashboard.lastLogType=="IN"?
                                            'Last Check-In at ${model.dashboard.lastLogTime.toString().toLowerCase()}.':"You're not check-in yet.",
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),

                            ],
                          ),
                        ),
                         Expanded(
                          flex: 1,
                           child: CircleAvatar(
                            radius: 35,

                            backgroundImage: NetworkImage(
                                           model.dashboard.employeeImage ?? "",
                                         ), // Replace with your image asset
                                               ),
                         ),

                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                          Center(
                          child: OutlinedButton(
                            onPressed: () {
                              String logtype= model.dashboard.lastLogType=="IN" ? "OUT" :"IN";
                              Logger().i(logtype);
                              model.employeelog(logtype);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: BorderSide(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red), // Set the border color
                              minimumSize: const Size(150, 50), // Set the minimum button size
                            ),
                            child:model.loading?LoadingAnimationWidget.hexagonDots(
                                          color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red,
                                          size: 18,
                                        ) :Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(model.dashboard.lastLogType=="OUT" ? 'assets/images/check-in.png':'assets/images/check-out.png',scale: 20),
                  SizedBox(width: 8),
                  Text(model.dashboard.lastLogType=="OUT" ? 'Check-In':'Check-Out',style: TextStyle(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red),),
                              ],
                            ),
                          ),
                        ),

                  ],
                              ),
                            ),
                          ),
                        SizedBox(height: 20,)
                        ,Text('What would you like to do ?',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                  Container(
                              padding: EdgeInsets.all(8),
                              height: double.maxFinite,
                              child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3 , mainAxisSpacing: 20, crossAxisSpacing: 20 ),children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.leadListScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/recruitment.png',scale: 10,),
                                        AutoSizeText("Lead",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.listQuotationScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/quotation.png',scale: 10,),
                                        AutoSizeText("Quotation",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.listOrderScreen);
                                  },
                                  child: Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          Image.asset('assets/images/cargo.png',scale: 10,),

                                        AutoSizeText("Sales Orders", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,),),

                                      ],
                                    ),
                                  ),
                                ),


                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.holidayScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/calendar.png',scale: 10,),
                                        AutoSizeText("Holidays",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.attendanceScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/attendance.png',scale: 10,),
                                        AutoSizeText("Attendence",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.expenseScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/budget.png',scale: 10,),
                                        AutoSizeText("Expenses",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.listLeaveScreen);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset:  Offset(0, 3), // Customize the shadow offset
                                        ),
                                      ],
                                    ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/flight.png',scale: 10,),
                                        const AutoSizeText("Leaves",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                      ],),
                                  ),
                                ),
                              ],
                              ),

                            ),    Container(
    width: 360,
    height: 640,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
    child: Stack(
    children: [
    Positioned(
    left: 13,
    top: 89,
    child: Container(
    width: 335,
    height: 168,
    decoration: ShapeDecoration(
    color: Color(0xFFF5F5F5),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    ),
    ),
    Positioned(
    left: 133,
    top: 218,
    child: Text(
    'Absent',
    style: TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    Positioned(
    left: 52,
    top: 218,
    child: SizedBox(
    width: 45,
    child: Text(
    'Present',
    style: TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    ),
    Positioned(
    left: 111,
    top: 165,
    child: Text(
    '1 Days  ',
    style: TextStyle(
    color: Color(0xFFD21C1C),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    Positioned(
    left: 33,
    top: 104,
    child: Container(
    width: 117,
    height: 30,
    decoration: ShapeDecoration(
    color: Color(0xFFD9D9D9),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    ),
    ),
    Positioned(
    left: 56.06,
    top: 110,
    child: SizedBox(
    width: 61,
    height: 17,
    child: Text(
    'December',
    style: TextStyle(
    color: Color(0xFF1E75F6),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 0,
    ),
    ),
    ),
    ),
    Positioned(
    left: 33,
    top: 165,
    child: Text(
    '29 Days  ',
    style: TextStyle(
    color: Color(0xFF06AA03),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    Positioned(
    left: 91,
    top: 163,
    child: Transform(
    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
    child: Container(
    width: 18,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    ),
    ),
    ),
    ),
    ),
    ),
    Positioned(
    left: 91,
    top: 163,
    child: Transform(
    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
    child: Container(
    width: 18,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    ),
    ),
    ),
    ),
    ),
    ),
    Positioned(
    left: 91,
    top: 163,
    child: Transform(
    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
    child: Container(
    width: 18,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    ),
    ),
    ),
    ),
    ),
    ),
    Positioned(
    left: 91,
    top: 163,
    child: Transform(
    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
    child: Container(
    width: 18,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    color: Color(0xFF7B7070),
    ),
    ),
    ),
    ),
    ),
    ),
    Positioned(
    left: 166,
    top: 163,
    child: Transform(
    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
    child: Container(
    width: 18,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    color: Color(0xFF7B7070),
    ),
    ),
    ),
    ),
    ),
    ),
    Positioned(
    left: 186,
    top: 166,
    child: Text(
    '0 Days  ',
    style: TextStyle(
    color: Color(0xFFD29F1C),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    Positioned(
    left: 274,
    top: 168,
    child: Text.rich(
    TextSpan(
    children: [
    TextSpan(
    text: '30 ',
    style: TextStyle(
    color: Color(0xFF6109D2),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    TextSpan(
    text: 'Days',
    style: TextStyle(
    color: Color(0xFF620AD2),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    TextSpan(
    text: '  ',
    style: TextStyle(
    color: Color(0xFF6109D2),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ],
    ),
    ),
    ),
    Positioned(
    left: 33,
    top: 221,
    child: Container(
    width: 12,
    height: 12,
    decoration: ShapeDecoration(
    color: Color(0xFF479B05),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 36,
    top: 224,
    child: Container(
    width: 6,
    height: 6,
    decoration: ShapeDecoration(
    color: Color(0xFFD9D9D9),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 111,
    top: 221,
    child: Container(
    width: 12,
    height: 12,
    decoration: ShapeDecoration(
    color: Color(0xFFD81010),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 114,
    top: 224,
    child: Container(
    width: 6,
    height: 6,
    decoration: ShapeDecoration(
    color: Color(0xFFD9D9D9),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 186,
    top: 221,
    child: Container(
    width: 12,
    height: 12,
    decoration: ShapeDecoration(
    color: Color(0xFFEEAE09),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 189,
    top: 224,
    child: Container(
    width: 6,
    height: 6,
    decoration: ShapeDecoration(
    color: Color(0xFFD9D9D9),
    shape: OvalBorder(),
    ),
    ),
    ),
    Positioned(
    left: 208,
    top: 218,
    child: Text(
    'Day off',
    style: TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    ),
    ),
    ),
    Positioned(
    left: 22,
    top: 57,
    child: SizedBox(
    width: 123,
    height: 15,
    child: Text(
    'Attendance Details ',
    style: TextStyle(
    color: Color(0xFF0A46A0),
    fontSize: 13,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 0,
    ),
    ),
    ),
    ),
    Positioned(
    left: 12,
    top: 320,
    child: Container(
    width: 336,
    height: 199,
    child: Stack(
    children: [
    Positioned(
    left: 0,
    top: 0,
    child: Container(
    width: 944,
    height: 199,
    child: Stack(
    children: [
    Positioned(
    left: 485,
    top: 0,
    child: Container(
    width: 336,
    height: 198,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ),
    ),
    ),
    Positioned(
    left: 0,
    top: 23,
    child: Container(
    width: 401,
    height: 176,
    child: Stack(
    children: [
    Positioned(
    left: 0,
    top: 0,
    child: Container(
    width: 129,
    height: 176,
    child: Stack(
    children: [
    Positioned(
    left: 0,
    top: 0,
    child: Container(
    width: 129,
    height: 176,
    decoration: ShapeDecoration(
    color: Color(0xFF81A67B),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    ),
    shadows: [
    BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 4),
    spreadRadius: 0,
    )
    ],
    ),
    ),
    ),
    Positioned(
    left: 28,
    top: 136,
    child: Text(
    'Casual Leave',
    style: TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 0,
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    Positioned(
    left: 136,
    top: 0,
    child: Container(
    width: 129,
    height: 176,
    decoration: ShapeDecoration(
    color: Color(0xFF81A67B),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    ),
    shadows: [
    BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 4),
    spreadRadius: 0,
    )
    ],
    ),
    ),
    ),
    Positioned(
    left: 272,
    top: 0,
    child: Container(
    width: 129,
    height: 176,
    decoration: ShapeDecoration(
    color: Color(0xFF81A67B),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    ),
    shadows: [
    BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 4),
    spreadRadius: 0,
    )
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    Positioned(
    left: 408,
    top: 23,
    child: Container(
    width: 401,
    height: 176,
    child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    width: 129,
    height: 176,
    decoration:  ShapeDecoration(
    color: Color(0xFF81A67B), shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      shadows: [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(0, 4),
        spreadRadius: 0,
      )
    ],
    ),
    ),
      const SizedBox(width: 7),
      Container(
        width: 129,
        height: 176,
        decoration: ShapeDecoration(
          color: Color(0xFF81A67B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
      ),
      const SizedBox(width: 7),
      Container(
        width: 129,
        height: 176,
        decoration: ShapeDecoration(
          color: Color(0xFF81A67B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
      ),
      ],
    ),
    ),
    ),
      Positioned(
        left: 815,
        top: 23,
        child: Container(
          width: 129,
          height: 176,
          decoration: ShapeDecoration(
            color: Color(0xFF81A67B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
    ],
    ),
    ),
    ),
      Positioned(
        left: 17,
        top: 49,
        child: Container(
          width: 100,
          height: 100,
          decoration: ShapeDecoration(
            color: Color(0xFFBD1212),
            shape: OvalBorder(),
          ),
        ),
      ),
    ],
    ),
    ),
    ),
      Positioned(
        left: 22,
        top: 305,
        child: Text(
          'Leave Balance',
          style: TextStyle(
            color: Color(0xFF0B47A0),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    ],
    ),
                          ),],
                      ),


                  ),
                ),
              ),
            ));
  }

}
