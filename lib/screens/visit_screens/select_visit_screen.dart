
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_model.dart';
import 'package:geolocation/screens/customer_screen/customer_list/customer_list_screen.dart';
import 'package:geolocation/screens/lead_screen/lead_list/lead_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

class SelectVisitScreen extends StatefulWidget {

  const SelectVisitScreen({super.key});

  @override
  State<SelectVisitScreen> createState() => _SelectVisitState();
}

class _SelectVisitState extends State<SelectVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateCustomerViewModel>.reactive(viewModelBuilder: ()=>UpdateCustomerViewModel(),onViewModelReady: (viewModel) => {}, builder: (context, model, child)=>WillPopScope(
      onWillPop: () async {
        if (model.isTimerRunning) {
          await model.saveTimerState();
        }
        return true;  },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Visit'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async =>{
              if (model.isTimerRunning) {
                await model.saveTimerState()
              },
              Navigator.pop(context)},

          ),
          actions: const [
          //  IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addCustomer,arguments: AddCustomerArguments(id: widget.id)), icon: Icon(Icons.edit))
          ],
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TabBar(
                        tabAlignment: TabAlignment.fill,
                        // isScrollable: true,
                        // indicator: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   color: Colors.blue,
                        // ),
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(

                            text: 'Customer List',
                          ),

                          Tab(
                            text: 'Lead',
                          )
                        ],
                      ),
                    ),
                     SizedBox(
                      height: MediaQuery.of(context).size.height-150,
                      child: // Inside the TabBarView
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TabBarView(
                          children: [
                            CustomerList(showAppBar: false),
                            LeadListScreen(showAppBar: false),
                          ],
                        ),
                      ),

                    ),

                  ],
                ),
              ),
              // User avatar and details section
            ],
          ),
        ),
      ),
    ));
  }
}
