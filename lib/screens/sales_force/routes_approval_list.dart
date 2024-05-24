
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_screen.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_view_model.dart';

import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/text_button.dart';


class RoutesApprovalList extends StatelessWidget {
  const RoutesApprovalList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');  // Specify the format you want
    return ViewModelBuilder<RouteApprovalViewModel>.reactive(
        viewModelBuilder: () => RouteApprovalViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialise(context,""),
        builder: (context, viewModel, child) => Scaffold(

          appBar: AppBar(
            title: const Text('Routes Master'),
            leading: IconButton.outlined(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.homePage);
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(onPressed: ()=>_showBottomSheet(context,viewModel), icon: Icon(Icons.filter_list_rounded))
            ],
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownButton2(
                            value: viewModel.selectedZone,
                            items: viewModel.getZones(),
                            hintText: 'Select zone',
                            labelText: 'Zones',
                            onChanged: (newValue) {
                              viewModel.setSelectedZone(newValue!);
                              viewModel.getRoutesAccordingToZones(newValue);
                            },
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: CustomDropdownButton2(
                            value: viewModel.selectedRegion,
                            items: viewModel.getRegions(),
                            hintText: 'Select Region',
                            labelText: 'Regions',
                            onChanged: (newValue) {
                              viewModel.setSelectedRegion(newValue!);
                              viewModel.getRoutesAccordingToRegions(newValue);
                            },
                          ),
                        ),
                        SizedBox(width: 5.0),

                      ],
                    ),
                    const SizedBox(height: 10.0),
                    CustomDropdownButton2(
                      value: viewModel.selectedArea,
                      items: viewModel.getAreas(),
                      hintText: 'Select Area',
                      labelText: 'Areas',
                      onChanged: (newValue) {
                        viewModel.setSelectedArea(newValue!);
                        viewModel.getRoutesAccordingToAreas(newValue);
                      },
                    ),


                    // CustomDropdownButton2(
                    //       value: viewModel.selectedZone,
                    //       items: viewModel.getZones(),
                    //       hintText: 'Select zone',
                    //       labelText: 'Zones',
                    //       onChanged:(newValue){
                    //         viewModel.setSelectedZone(newValue!);
                    //         viewModel.getRoutesAccordingToZones(newValue);
                    //       }),
                    //
                    //   const SizedBox(height: 10.0),
                    //   CustomDropdownButton2(
                    //       value: viewModel.selectedRegion,
                    //       items: viewModel.getRegions(),
                    //       hintText: 'Select Region',
                    //       labelText: 'Regions',
                    //       onChanged:(newValue){
                    //         viewModel.setSelectedRegion(newValue!);
                    //         viewModel.getRoutesAccordingToRegions(newValue);
                    //       }),
                    //
                    //
                    // const SizedBox(height: 10.0),
                    // CustomDropdownButton2(
                    //     value: viewModel.selectedArea,
                    //     items: viewModel.getAreas(),
                    //     hintText: 'Select Area',
                    //     labelText: 'Areas',
                    //     onChanged:(newValue){
                    //       viewModel.setSelectedArea(newValue!);
                    //       viewModel.getRoutesAccordingToAreas(newValue);
                    //     }),

                    viewModel.routes.isNotEmpty
                        ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: ()=>viewModel.refresh(),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (builder, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => RouteApprovalScreen(routeId:viewModel.routes[index].name!)
                                  ));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        const SizedBox(height: 10.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      viewModel.routes[index].routeName ?? 'Not available',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: viewModel.getColorForStatus(viewModel.routes[index].worflowState ?? ""),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Card(
                                                    color: viewModel.getColorForStatus(viewModel.routes[index].worflowState ?? ""),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        viewModel.routes[index].worflowState ?? 'Not available',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.normal,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const Text(
                                                'Created By',
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                viewModel.routes[index].owner ?? 'NA',
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                                              ),

                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          'Created Date',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          dateFormat.format(DateTime.parse('${viewModel.routes[index].creation}')) ?? "--",
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to the right side within the column
                                                      children: [
                                                        const Text(
                                                          'Approver',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          viewModel.routes[index].approver ?? 'NA',
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                          'Zone',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          viewModel.routes[index].zone ?? "--",
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Text(
                                                          'Region',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          viewModel.routes[index].region ?? "--",
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        const Text(
                                                          'Area',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          viewModel.routes[index].area ?? "--",
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )

                                            ],
                                          ),
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
                            itemCount: viewModel.routes.length),

                      ),
                    )
                        : Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: const Text('Sorry, you got nothing!',style: TextStyle(fontWeight: FontWeight.w700),),),
                    )
                  ],
                ),
              ),
              loader: viewModel.isBusy,
              context: context,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: ()=>Navigator.pushNamed(context, Routes.routeCreationForm),
            label: const Text('Create Route'),),
        )

    );

  }


  void _showBottomSheet(BuildContext context, RouteApprovalViewModel model) {

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
                  height: 350,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomDropdownButton2(
                        value: model.selectedZone,
                        prefixIcon: Icons.person_2,
                        items: model.getZones(),
                        hintText: 'Select zone',
                        labelText: 'Zones',
                        onChanged:(newValue){ model.setSelectedZone(newValue!);
                        }),

                      const SizedBox(height: 10.0),
                      CustomDropdownButton2(
                          value: model.selectedRegion,
                          prefixIcon: Icons.person_2,
                          items: model.getRegions(),
                          hintText: 'Select Region',
                          labelText: 'Regions',
                          onChanged:(newValue){ model.setSelectedZone(newValue!);
                          }),

                      const SizedBox(height: 10.0),
                      CustomDropdownButton2(
                          value: model.selectedArea,
                          prefixIcon: Icons.person_2,
                          items: model.getAreas(),
                          hintText: 'Select Area',
                          labelText: 'Areas',
                          onChanged:(newValue){ model.setSelectedZone(newValue!);
                          }),

                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CtextButton(
                            onPressed: () {
                              // model.clearfilter();
                              // Navigator.pop(
                              //     context); // Close the bottom sheet
                            },
                            text: 'Clear Filter',
                            buttonColor: Colors.black54,

                          ),
                          CtextButton(
                            onPressed: () {
                              // model.setfilter(model.territory ?? "",
                              //     model.custm ?? "");
                              // Navigator.pop(context);
                            },
                            text: 'Apply Filter',
                            buttonColor: Colors.white,

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
