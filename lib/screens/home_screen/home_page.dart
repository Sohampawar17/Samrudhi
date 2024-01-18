import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/router.router.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
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
                title:  Text(model.dashboard.company ?? "",style: const TextStyle(fontSize: 17),),
              ),
              drawer: myDrawer(context, (model.dashboard.empName ?? ""),
                  (model.user ?? ""), (model.dashboard.employeeImage ?? "")),
              body: WillPopScope(
                onWillPop: showExitPopup,
                child: fullScreenLoader(
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
                                  model.greeting ?? "",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "${model.dashboard.empName.toString().toUpperCase()},",overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                 Text( model.dashboard.lastLogType=="IN"?
                                              'Last Check-In at ${model.dashboard.lastLogTime.toString()}':"You're not check-in yet",
                                              style: const TextStyle(fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),

                              ],
                            ),
                          ),
                           Expanded(
                            flex: 1,
                             child: CircleAvatar(
                               backgroundColor: Colors.black,
                               radius: 40,
                               child: CircleAvatar(
                                 backgroundColor: Colors.white,
                                 radius: 35,
                                 child: Image.network(
                                   '${model.dashboard.employeeImage}',
                                   height: 40,
                                   loadingBuilder: (BuildContext context, Widget child,
                                       ImageChunkEvent? loadingProgress) {
                                     if (loadingProgress == null) {
                                       // Image is done loading
                                       return child;
                                     } else {
                                       // Image is still loading
                                       return const Center(
                                           child: CircularProgressIndicator(color: Colors.blueAccent));
                                     }
                                   },
                                   errorBuilder:
                                       (BuildContext context, Object error, StackTrace? stackTrace) {
                                     // Handle the error by displaying a broken image icon
                                     return  Center(
                                         child: Image.asset('assets/images/profile.png',scale: 5,));
                                   },
                                 ),
                               ),

                             ),
                           )
                        ],
                      ),
                      const SizedBox(
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
                                side: BorderSide(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red,width: 2), // Set the border color
                                minimumSize: const Size(150, 50), // Set the minimum button size
                              ),
                              child:model.loading?LoadingAnimationWidget.hexagonDots(
                                            color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red,
                                            size: 18,
                                          ) :Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(model.dashboard.lastLogType=="OUT" ? 'assets/images/check-in.png':'assets/images/check-out.png',scale: 20),
                    const SizedBox(width: 8),
                    Text(model.dashboard.lastLogType=="OUT" ? 'Check-In':'Check-Out',style: TextStyle(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red),),
                                ],
                              ),
                            ),
                          ),

                    ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,)
                          ,const Text('What would you like to do ?',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                    Container(
                                padding: const EdgeInsets.all(8),

                                child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3 , mainAxisSpacing: 20, crossAxisSpacing: 20 ),controller: ScrollController(keepScrollOffset: true),shrinkWrap: true,children: [
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/recruitment.png',scale: 10,),
                                          const AutoSizeText("Lead",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/quotation.png',scale: 10,),
                                          const AutoSizeText("Quotation",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                            Image.asset('assets/images/cargo.png',scale: 10,),
                                          const AutoSizeText("Sales Orders", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,),),

                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.listInvoiceScreen);
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/bill.png',scale: 10,),
                                          const AutoSizeText("Sales Invoice",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/calendar.png',scale: 10,),
                                          const AutoSizeText("Holidays",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/attendance.png',scale: 10,),
                                          const AutoSizeText("Attendence",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/budget.png',scale: 10,),
                                          const AutoSizeText("Expenses",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
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
                                            offset:  const Offset(0, 3), // Customize the shadow offset
                                          ),
                                        ],
                                      ),
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset('assets/images/flight.png',scale: 10,),
                                          const AutoSizeText("Leaves",style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w600),)
                                        ],),
                                    ),
                                  ),
                                ],
                                ),
                              ),
                            const SizedBox(height: 20,),
                            const Text('Attendance Details',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10,),
                            Container(
                              width: getWidth(context),
                              padding: const EdgeInsets.all(8),
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
                              // Set a fixed width for the container
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Card(
                                    color: Colors.blueAccent,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          20.0),
                                      // Set border color and width
                                    ),
                                    // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                                    child:  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: AutoSizeText(model.attendancedashboard.monthTitle ??"",
minFontSize: 15,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),),
                                    ),

                                  ),
                                  const SizedBox(height: 10,),
                                   Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      Text('${model.attendancedashboard.present ?? 0} Days',textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.w700,color: Colors.green)),
                                      Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                      Text('|',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                      Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                      Text('${model.attendancedashboard.absent ?? 0} Days',textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.w700,color: Colors.redAccent)),
                                      Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                      Text('|',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                      Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                      Text('${model.attendancedashboard.dayOff ?? 0} Days',textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.w700,color: Colors.yellow[700])),
                                      Divider(thickness: 5,color: Colors.black,indent: 40,height: 20,),
                                      Text('${model.attendancedashboard.totalDays ?? 0} Days',textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
                                    ],),
                                  ),

                                  LinearPercentIndicator(
                                    width: getWidth(context) / 1.18,
                                    lineHeight: 13.0,
                                    percent: (model.attendancedashboard.tillDays ?? 0) /
                                        (model.attendancedashboard.totalDays ?? 1), // Added null checks
                                    barRadius: const Radius.circular(20),
                                    center: Text(
                                      "${(model.attendancedashboard.tillDays ?? 0)} days",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),
                                    ),
                                    progressColor: Colors.blueAccent,
                                  ),


                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                      Icon(Icons.radio_button_checked,color: Colors.green,),
                                      Text('Present',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                      const SizedBox(width: 20,),
                                      Icon(Icons.radio_button_checked,color: Colors.red,),
                                      Text('Absent',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                      const SizedBox(width: 20,),
                                      Icon(Icons.radio_button_checked,color: Colors.yellow[700],),
                                      Text('Days Off',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),

                                    ],),
                                  ),
                                ]
                              ),
                            ),
                            const SizedBox(height: 20,),

                            const Text('Leave Balance',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                            // Existing code...
                            SizedBox(

                              width: getWidth(context),
                              height: getHeight(context)/4, // Adjust the height as needed
                              child: SizedBox(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.leavelist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(10),
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
                                        // Set a fixed width for the container
                                        child: CircularPercentIndicator(
                                          radius: 45.0,
                                          lineWidth: 8.0,

                                          percent:model.leavelist[index].leaveType != "Leave Without Pay" ?((model.leavelist[index].closingBalance ?? 0.0)/((model.leavelist[index].openingBalance ?? 0.0)+(model.leavelist[index].leavesAllocated ?? 0.0))):1,
                                          center: Text(
                                            model.leavelist[index].closingBalance!.abs().toString(),
                                            style:
                                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                          ),
                                          footer: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                model.leavelist[index].leaveType ?? "",
                                                style:
                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                              ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                              Text(
                                                "Allocated: ${(model.leavelist[index].leavesAllocated ?? 0.0).toString()}",
                                                style:
                                                const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          progressColor: Colors.blueAccent,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, builder) {
                                    return const SizedBox(
                                      width: 5,
                                    );
                                  },
                                ),
                              ),
                            ),
// Rest of the code...
                          ],
                        ),


                    ),
                  ),
                ),
              ),
            ));
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:const Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:const Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
