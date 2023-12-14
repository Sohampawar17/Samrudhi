import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/lead_list/lead_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeadListViewModel>.reactive(
      viewModelBuilder: () => LeadListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child)=> Scaffold(
        backgroundColor: Colors.grey.shade200,
appBar: AppBar(title: const Text('Lead'),
leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),),
body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      model.leadlist.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: ()=>model.refresh(),
                                child: ListView.separated(
                                    itemBuilder: (builder, index) {
                                      return Container(
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
                                        child: GestureDetector(
                                        onTap: ()=>model.onRowClick(context, model.leadlist[index]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          model.leadlist[index]
                                                                  .name ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          model.leadlist[index]
                                                                  .leadName?.toUpperCase() ??
                                                              "",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w300
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                        side: BorderSide(
                                                            color: Colors.black26,
                                                            width:
                                                                1), // Set border color and width
                                                      ),
                                                     
                                                      // Make the inside of the card hollow
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10.0),
                                                        child: AutoSizeText(
                                                          model.leadlist[index]
                                                                  .status ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Company Name',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          model.leadlist[index]
                                                                  .companyName?.toUpperCase() ??
                                                              "",
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Territory',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          model.leadlist[index]
                                                                  .territory
                                                                  ?.toString() ??
                                                              "",
                                                        ),
                                                      ],
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, builder) {
                                      return SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: model.leadlist.length),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
                floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: const AddLeadScreenArguments(leadid: '')),child: const Icon(Icons.add),),
      ));
  }
}