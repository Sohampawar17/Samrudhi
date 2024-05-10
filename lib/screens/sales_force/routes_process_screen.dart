import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_force/assigned_routes/assigned_routes_view.dart';
import 'package:geolocation/screens/sales_force/route_assignment_form.dart';
import 'package:geolocation/screens/sales_force/add_route_creation/route_creation_form.dart';
import 'package:geolocation/screens/sales_force/routes_approval_list.dart';

class RouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Sales Force Management'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/sales_force.png'), // Adjust the image path as needed
              SizedBox(height: 20), // Add some space between image and buttons

              Card(
                elevation: 4,
                child: ListTile(
                  title: Text('Route Creation'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RouteCreationForm()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text('Route Approval'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoutesApprovalList()),
                    );
                    // Handle button 3 press
                  },
                ),
              ),
              SizedBox(height: 10),// Add some space between buttons
              Card(
                child: ListTile(

                  title: Text('Routes Assignment'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RouteAssignmentForm()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(

                  title: Text('Routes Reports'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AssignedRoutesScreen()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),

            ],
          ),
        ),

    );
  }
}