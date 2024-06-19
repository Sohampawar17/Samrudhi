
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/registration/retailer/reatiler_list/retailer_list_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../../router.router.dart';
import '../../../../widgets/customtextfield.dart';


class RetailerListScreen extends StatefulWidget {
  const RetailerListScreen({super.key});

  @override
  State<RetailerListScreen> createState() => _RetailerListScreenState();
}

class _RetailerListScreenState extends State<RetailerListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerListViewModel>.reactive(
        viewModelBuilder: () => RetailerListViewModel(),
    onViewModelReady: (model) => model.initialise(context),
    builder: (context, model, child) =>Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text('Retailers'),

    ),
      body: fullScreenLoader(loader: model.isBusy, child:  Column(
        children: [
          CustomSmallTextFormField(prefixIcon: Icons.search,controller: model.searchController, labelText: 'Search by shop name or owner', hintText: 'Type here to search',onChanged: model.searchItems,),

          const SizedBox(height: 15),
          model.filterRetailerList.isNotEmpty
              ? Expanded(
            child: RefreshIndicator(
              onRefresh: ()=>model.refresh(),
              child: ListView.separated(
                padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (builder, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                            // spreadRadius: 5,
                            blurRadius: 7,
                            // offset: const Offset(0, 3), // Customize the shadow offset
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: ()=>model.onRowClick(context, model.filterRetailerList[index]) ,
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
                                        model.filterRetailerList[index]
                                            .nameOfTheShopOwner?.toUpperCase() ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                      Text(DateFormat.yMMMEd().format(DateTime.parse(model.filterRetailerList[index]
                                          .creation.toString())),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  buildItemColumn(additionalText: model.filterRetailerList[index]
                                      .nameOfTheShop?.toUpperCase() ??
                                      "", labelText: 'Shop Name'),
                                  buildItemColumn(additionalText:  model.filterRetailerList[index]
                                      .territorry
                                      ?.toString() ??
                                      "N/A", labelText: 'Territory'),


                                ],

                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, builder) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: model.filterRetailerList.length),
            ),
          )
              : Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text('Sorry, you got nothing!',style: TextStyle(fontWeight: FontWeight.w700),),),
          )
        ],
      ), context: context),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()=> Navigator.pushNamed(context, Routes.addRetailerScreen,arguments: const AddRetailerScreenArguments(retailerId: '')),label: const Text('Create Retailer'),),
    ));
  }
  Widget buildItemColumn( {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(labelText,style: const TextStyle(fontWeight: FontWeight.w400),minFontSize: 15,),
        AutoSizeText(additionalText,style: const TextStyle(fontWeight: FontWeight.bold),maxFontSize: 20,),
      ],
    );
  }
  // void _showBottomSheet(BuildContext context, RetailerListViewModel model) {
  //
  //   SchedulerBinding.instance.addPostFrameCallback(
  //           (_) {
  //         showModalBottomSheet(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return Scaffold(
  //               appBar: AppBar(
  //                 title: const Text('Filters'),
  //               ),
  //               body: SingleChildScrollView(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: Column(
  //                     children: [
  //                       CustomDropdownButton2(
  //                         value: model.custm,
  //                         prefixIcon: Icons.person_2,
  //                         items: model.customerlist,
  //                         hintText: 'Select the Lead Name',
  //                         labelText: 'Lead Name',
  //                         onChanged: model.setcustomer,
  //                       ),
  //                       const SizedBox(height: 10.0),
  //                       CustomDropdownButton2(
  //                         value: model.request,
  //                         prefixIcon: Icons.request_page,
  //                         items: model.requestType,
  //                         hintText: 'Select the Request Type',
  //                         labelText: 'Request Type',
  //                         onChanged: model.setRequest,
  //                       ),
  //
  //                       const SizedBox(height: 20.0),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           CtextButton(
  //                             onPressed: () {
  //                               model.clearfilter();
  //                               Navigator.pop(
  //                                   context); // Close the bottom sheet
  //                             },
  //                             text: 'Clear Filter',
  //                             buttonColor: Colors.black54,
  //
  //                           ),
  //                           CtextButton(
  //                             onPressed: () {
  //                               model.setfilter(
  //                                   model.custm ?? "",model.request ?? "");
  //                               Navigator.pop(context);
  //                             },
  //                             text: 'Apply Filter',
  //                             buttonColor: Colors.blueAccent.shade400,
  //
  //                           ),
  //
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       }
  //   );
  // }
}
