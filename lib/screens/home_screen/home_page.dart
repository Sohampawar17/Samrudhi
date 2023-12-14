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
                                "${model.dashboard.empName.toString().toUpperCase()}",overflow: TextOverflow.ellipsis,
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

                            )      ],
                      ),


                  ),
                ),
              ),
            ));
  }

}
