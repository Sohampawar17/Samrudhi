
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_screen.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_view_model.dart';

import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';



class RoutesApprovalList extends StatelessWidget {
  const RoutesApprovalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteApprovalViewModel>.reactive(
        viewModelBuilder: () => RouteApprovalViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,""),
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            title: const Text('Routes Approval'),
            leading: IconButton.outlined(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.homePage);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: WillPopScope(
            onWillPop: ()  async{
              Navigator.pop(context);
              return true; },
            child: fullScreenLoader(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    viewModel.routes.isNotEmpty
                        ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: ()=>viewModel.refresh(),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (builder, index) {
                              return Card(
                                child: ListTile(
                                  leading:  Icon(
                                    Icons.route,
                                    size: 34, // Adjust the size of the icon as needed
                                  ),
                                  title: Text(viewModel.routes[index].routeName?? 'Not available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.blueGrey)),
                                  trailing: Card(color:Colors.orange,child: Padding(padding:EdgeInsets.all(8.0),child: Text(viewModel.routes[index].worflowState?? 'Not available', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,color: Colors.white60)))),
                                  onTap: () {
                                  // viewModel.setSelectedString(viewModel.routes[index].name!);

                                   Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => RouteApprovalScreen(routeId:viewModel.routes[index].name!)
                                    ));
                                  },
                                ),
                              );
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         const Text(
                                  //             'Customer name',
                                  //             style: TextStyle(color: Colors.black87, fontWeight:  FontWeight.w300)
                                  //         ),
                                  //         Container(
                                  //           width: 150, // Adjust the width as needed
                                  //           child: Text(
                                  //             model.filterorderlist[index].customerName ?? "",
                                  //             style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                  //             overflow: TextOverflow.ellipsis,
                                  //             maxLines: 2,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         const Text(
                                  //           'Items',
                                  //           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
                                  //         ),
                                  //         Text(
                                  //           model.filterorderlist[index].totalQty?.toString() ?? "0.0",
                                  //           style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         const Text(
                                  //           "Amount",
                                  //           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
                                  //         ),
                                  //         Text(
                                  //           model.filterorderlist[index].grandTotal?.toString() ?? "0.0",
                                  //           style: const TextStyle(
                                  //             fontWeight: FontWeight.w500,
                                  //             color: Colors.green,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),


                            },
                            separatorBuilder: (context, builder) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: viewModel.routes.length),
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
              loader: viewModel.isBusy,
              context: context,
            ),
          ),
        ));
  }



}
