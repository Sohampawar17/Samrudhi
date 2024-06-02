import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import 'list_salesorder_viewmodel.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListOrderModel>.reactive(
        viewModelBuilder: () => ListOrderModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.grey.shade300,
              appBar: AppBar(
                title: const Text('Sales Order'),actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
          _showBottomSheet(context,model);
              },
            ),
          ],

              ),
              body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      model.filterorderlist.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: ()=>model.refresh(),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
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
                                          onPressed: () => model.onRowClick(
                                              context, model.filterorderlist[index]),
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
                                                          model.filterorderlist[index]
                                                                  .name ??
                                                              "",
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          model.filterorderlist[index]
                                                                  .transactionDate ??
                                                              "",
                                                          style: const TextStyle(
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
                                                                20.0),
                                                       // Set border color and width
                                                      ),
                                                      color: model
                                                          .getColorForStatus(model
                                                                  .filterorderlist[
                                                                      index]
                                                                  .customOrderStatus ??
                                                              ""),
                                                      // Make the inside of the card hollow
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10.0),
                                                        child: AutoSizeText(
                                                          model.filterorderlist[index]
                                                                  .customOrderStatus ??
                                                              "",
                                                              minFontSize: 8,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15.0),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                            'Customer name',
                                                            style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w300)
                                                        ),
                                                        Container(
                                                          width: 150, // Adjust the width as needed
                                                          child: Text(
                                                            model.filterorderlist[index].customerName ?? "",
                                                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          'Items',
                                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
                                                        ),
                                                        Text(
                                                          model.filterorderlist[index].totalQty?.toString() ?? "0.0",
                                                          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          "Amount",
                                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
                                                        ),
                                                        Text(
                                                          model.filterorderlist[index].grandTotal?.toString() ?? "0.0",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.green,
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
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: model.filterorderlist.length),
                              ),
                            )
                          : Center(
                            child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: const Text('Sorry, you got nothing!',textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.w700),),),
                          )
                    ],
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addOrderScreen,
                      arguments: const AddOrderScreenArguments(orderid: ""));
                },
                label: const Text('Create Order'),
              ),
            ));
  }

  void _showBottomSheet(BuildContext context, ListOrderModel model) {

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

                            value: model.custm,
                            prefixIcon: Icons.person_2,
                            items: model.searchcutomer,
                            hintText: 'Select the customer',
                            labelText: 'Customer',
                            onChanged: model.setcustomer,
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            readOnly: true,
                            controller: TextEditingController(text: model.date),
                            onTap: () => model.selectdeliveryDate(context),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              labelText: 'Date',
                              hintText: 'Select a Date',
                              prefixIcon: const Icon(
                                  Icons.calendar_today_rounded),
                              labelStyle: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CtextButton(
                                onPressed: () {
                                  model.clearfilter();
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                },
                                text: 'Clear Filter',
                                buttonColor: Colors.black54,
                               
                              ),
                              CtextButton(
                                onPressed: () {
                                  model.setfilter(
                                      model.custm ?? "", model.date ?? "");
                                  Navigator.pop(context);
                                },
                                text: 'Apply Filters',
                                buttonColor: Colors.blueAccent.shade400,
                                
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
