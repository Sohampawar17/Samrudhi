import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/route_approval_view_model.dart';
import 'package:geolocation/screens/sales_force/route_creation_view_model.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../model/get_teritorry_details.dart';

class RouteApprovalScreen extends StatefulWidget {

  final String routeId;

  const RouteApprovalScreen({super.key, required this.routeId});

  @override
  _RouteApprovalScreenState createState() => _RouteApprovalScreenState();
}

class _RouteApprovalScreenState extends State<RouteApprovalScreen> {
  List<TerritoryData> _territoryList = [];
  TextEditingController _routeNameController = TextEditingController();
  String? _workflowStatus;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RouteApprovalViewModel>.reactive(
      viewModelBuilder: () => RouteApprovalViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context,widget.routeId),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Route Approval'),
        ),
        body: fullScreenLoader(
          loader: viewModel.isBusy,
          context: context,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Route Name:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  viewModel.routesAll.routename!.isEmpty ? '--' : viewModel.routesAll.routename!,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Waypoints:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: viewModel.routesAll.waypoints!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final territory = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      _buildTimelineLine(), // Add line between dots
                        Row(
                          children: [
                            if(index != 0)
                            _buildTimelineDot(),
                            SizedBox(width: 10), // Add some space between dot and title
                            _buildTimelineTitle(territory!.territory!),
                          ],
                        ),
                        // Add a divider between each timeline event
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                CustomDropdownButton2(
                  items:<String>['Approved', 'Rejected'],
                  hintText: 'Choose state',
                  onChanged: (String? newValue) {_workflowStatus=newValue;  }, labelText: 'Status',),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> payload = {
                      "workflow_state":_workflowStatus,

                    };
                    viewModel.ediStatus(widget.routeId,payload);
                  },
                  child: Text('Update Status'),
                ),

              ]
            ),
          ),
        ),
      ),
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
