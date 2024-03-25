import 'package:flutter/material.dart';
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/custom_button.dart';

class UpdateCustomer extends StatefulWidget {
  final String id;
  const UpdateCustomer({super.key, required this.id});

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateCustomerViewModel>.reactive(viewModelBuilder: ()=>UpdateCustomerViewModel(),onViewModelReady: (model) => model.initialise(context,widget.id), builder: (context, model, child)=>Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(model.customerData.name ??"",style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          
        ),
        actions: [
          IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addCustomer,arguments: AddCustomerArguments(id: widget.id)), icon: Icon(Icons.edit))
        ],
      ),
      body: fullScreenLoader(
        loader: model.isBusy,
        context: context,
        child: SingleChildScrollView(
physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                color: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receivable\n RS. 100',
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                       Divider(thickness: 2,color: Colors.white,height: 20,),
                        Text(
                          'Used Credits\n RS. 200',
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Text(
                      'To Packed: 1',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'To Be Shipped: 2',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 10),
              DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
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

                            text: 'Details',
                          ),

                          Tab(
                            text: 'Transaction',
                          ),
                          Tab(
                            text: 'Comments',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 240,
                      child: // Inside the TabBarView
                      TabBarView(
                        children: [
                          // Details Tab Content
                          Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.account_circle_outlined),
                                    SizedBox(width: 16.0),
                                    Text(
                                      model.customerData.customerName ?? "",
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone_outlined),
                                    SizedBox(width: 16.0),
                                    Text(
                                      model.customerData.mobileNo ?? "",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email_outlined),
                                    SizedBox(width: 16.0),
                                    Text(
                                      model.customerData.emailId ?? "",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      icon: Icons.phone_outlined,
                                      text: 'Mobile',
                                      onPressed: () => model.service.call(model.customerData.mobileNo ?? ""),
                                    ),
                                    CustomButton(
                                      icon: Icons.email_outlined,
                                      text: 'Email',
                                      onPressed: () => model.service.sendEmail(model.customerData.emailId ?? ""),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Transaction Tab Content
                         Container(child: // Transaction Tab Content
                         ListView(
                           children: [
                             // Filter options
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   // Add your filter options here
                               Container(
                               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                           decoration: BoxDecoration(
                             color: Colors.grey[300],
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Text(
                             'All Orders',
                             style: TextStyle(
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                     decoration: BoxDecoration(
                                       color: Colors.grey[300],
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                     child: Text(
                                       'Pending',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                     decoration: BoxDecoration(
                                       color: Colors.grey[300],
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                     child: Text(
                                       'Completed',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                   // Add more filter options as needed
                                 ],
                               ),
                             ),
                             // List of orders
                             ListView.builder(
                               shrinkWrap: true,
                               itemCount: model.orders.length,
                               itemBuilder: (context, index) {
                                 final order = model.orders[index];
                                 return ListTile(
                                   leading: Icon(Icons.shopping_cart),
                                   title: Text(order.title),
                                   subtitle: Text(order.description),
                                   trailing: Text('\$${order.amount}'),
                                   onTap: () {
                                     // Add onTap functionality here if needed
                                   },
                                 );
                               },
                             ),
                           ],
                         ),
                             ),
                          // Comment Tab Content
                          Column(
                            children: [
                              Expanded(
                                child: ListView.builder(

                                  shrinkWrap: true,
                                  itemCount: 5, // Replace with your comment list length
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text('Comment $index'),
                                      subtitle: Text('Comment details'),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Add a comment...',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add comment logic here
                                      },
                                      child: Text('Add'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
