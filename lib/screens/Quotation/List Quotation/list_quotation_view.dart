import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_quotation_model.dart';

class ListQuotationScreen extends StatelessWidget {
  const ListQuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListQuotationModel>.reactive(
        viewModelBuilder: () => ListQuotationModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Quotation'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  _showBottomSheet(context,model);
                },
              ),
            ],
            leading: IconButton.outlined(onPressed: ()=>Navigator.popAndPushNamed(context, Routes.homePage), icon: const Icon(Icons.arrow_back)),),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  model.filterquotationlist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (builder, index) {
                          return  Container(
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
                               onTap: () => model.onRowClick(
                                   context, model.filterquotationlist[index]),
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
                                              model.filterquotationlist[index]
                                                  .name ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              model.filterquotationlist[index]
                                                  .transactionDate ??
                                                  "",
                                              style: TextStyle(
                                                color: Colors.grey,
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
                                          color: model
                                              .getColorForStatus(model
                                              .filterquotationlist[
                                          index]
                                              .status ??
                                              ""),
                                          // Make the inside of the card hollow
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                10.0),
                                            child: AutoSizeText(
                                              model.filterquotationlist[index]
                                                  .status ??
                                                  "",
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
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
                                              'Customer name',
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              model.filterquotationlist[index]
                                                  .customerName ??
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
                                              'Items',
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              model.filterquotationlist[index]
                                                  .totalQty
                                                  ?.toString() ??
                                                  "0.0",
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "Amount",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${model.filterquotationlist[index].grandTotal?.toString() ?? "0.0"}',
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: Colors
                                                    .green, // You can change the color
                                              ),
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
                        itemCount: model.filterquotationlist.length),
                  )
                      : Container()
                ],
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.addQuotationView, arguments: AddQuotationViewArguments(quotationid: "")
                 );
            },
            child: Icon(Icons.add),
          ),
        ));
  }



  void _showBottomSheet(BuildContext context, ListQuotationModel model) {

    SchedulerBinding.instance.addPostFrameCallback(
            (_) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Filters'),
                ),
                body: Container(
                  height: 250,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(

                    children: [
                      CustomDropdownButton2(
                        value: model.quotationto,
                        prefixIcon: Icons.person_2,
                        items: model.quotation,
                        hintText: 'Select the Quotation To',
                        labelText: 'Quotation To',
                        onChanged: model.setquotationto,
                      ),
                      SizedBox(height: 10.0),
                      CustomDropdownButton2(
                        value: model.custm,
                        prefixIcon: Icons.person_2,
                        items: model.customer,
                        hintText: 'Select the customer',
                        labelText: 'Customer',
                        onChanged: model.setcustomer,
                      ),
                      // TextFormField(
                      //   readOnly: true,
                      //   controller: TextEditingController(text: model.date),
                      //   onTap: () => model.selectdeliveryDate(context),
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 12.0),
                      //     labelText: 'Date',
                      //     hintText: 'Select a Date',
                      //     prefixIcon: const Icon(
                      //         Icons.calendar_today_rounded),
                      //     labelStyle: const TextStyle(
                      //       color: Colors.black54,
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     hintStyle: const TextStyle(
                      //       color: Colors.grey,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(18.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(18.0),
                      //       borderSide: const BorderSide(
                      //         color: Colors.blue,
                      //       ),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(18.0),
                      //       borderSide: const BorderSide(
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              model.clearfilter();
                              Navigator.pop(
                                  context); // Close the bottom sheet
                            },
                            child: Text('Clear Filter'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              model.setfilter(model.quotationto ?? "",
                                  model.custm ?? "");
                              Navigator.pop(context);
                            },
                            child: Text('Apply Filter'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

}
