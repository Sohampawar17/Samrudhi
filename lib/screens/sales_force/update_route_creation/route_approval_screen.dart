import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/update_route_creation/route_approval_view_model.dart';

import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../model/get_teritorry_details.dart';

class RouteApprovalScreen extends StatefulWidget {

  final String routeId;

  const RouteApprovalScreen({super.key, required this.routeId});

  @override
  _RouteApprovalScreenState createState() => _RouteApprovalScreenState();
}

class _RouteApprovalScreenState extends State<RouteApprovalScreen> {
  List<TerritoryData> territoryList = [];
  TextEditingController routeNameController = TextEditingController();
  String? _workflowStatus;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteApprovalViewModel>.reactive(
      viewModelBuilder: () => RouteApprovalViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context,widget.routeId),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.routesAll.name ?? ""),
        ),
        body: fullScreenLoader(
          loader: viewModel.isBusy,
          context: context,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(flex: 4,
                      child: AutoSizeText(
                        viewModel.routesAll.name ?? "",

                        style: const TextStyle(
                          fontSize: 17,
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.indigo
                        ),),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(

                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    viewModel.routesAll.workflowState ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: viewModel.getColorForStatus(viewModel.routesAll.workflowState.toString()),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton(

                                icon:  Icon(Icons.arrow_drop_down, color: viewModel.getColorForStatus(viewModel.routesAll.workflowState.toString())),
                                itemBuilder: (BuildContext context) =>
                                    viewModel.status.map<PopupMenuItem<String>>((String item) {
                                      // Populate menu items from fetched data
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                onSelected: (value) {
                                  viewModel.changeState(context,value);
                                },
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(height: 20),
                const Text(
                  'Waypoints',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: viewModel.routesAll.waypoints!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final territory = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          _buildTimelineLine(), // Add line between dots
                        Row(
                          children: [
                            _buildTimelineDot(),
                            SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(territory.territory!),
                          ],
                        ),
                        // Add a divider between each timeline event
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),minFontSize: 18,),
        AutoSizeText(
            additionalText, style: const TextStyle(fontWeight: FontWeight.w500),minFontSize: 17),
      ],
    );
  }

  Widget _buildTimelineLine() {
    return Container(
      width: 2,
      height: 20,
      color: Colors.blue, // Customize the color as needed
    );
  }

  Widget _buildTimelineDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, // Customize the color as needed
      ),
    );
  }

  Widget _buildTimelineTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

}
