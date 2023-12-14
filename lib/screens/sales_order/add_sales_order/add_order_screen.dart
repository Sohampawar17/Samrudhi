import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/sales_order/list_sales_order/list_sales_order_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../../constants.dart';
import '../../../model/add_order_model.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';
import 'add_order_viewmodel.dart';

class AddOrderScreen extends StatefulWidget {
  final String orderid;

  const AddOrderScreen({super.key, required this.orderid});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddOrderViewModel>.reactive(
      viewModelBuilder: () => AddOrderViewModel(),
      onViewModelReady: (model) => model.initialise(context, widget.orderid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.orderdata.name ?? "")
              : const Text('Create Order'),
          leading: IconButton.outlined(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.listOrderScreen);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [IconButton.outlined(
            onPressed: () {
              model.onSavePressed(context);
            },
            icon: const Icon(Icons.check),
          ),],
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
              child: Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownButton2(value: model.orderdata.customer,prefixIcon: Icons.person_2,items: model.searchcutomer, hintText: 'Select the customer', labelText: 'Customer', onChanged:  model.setcustomer,),

                  const SizedBox(
                    height: 15,
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child:CustomDropdownButton2(items:model.ordetype, hintText: 'select the order type', onChanged: model.setordertype, labelText: 'Order Type',value: model.orderdata.orderType,),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          controller: model.deliverydatecontroller,
                          onTap: () => model.selectdeliveryDate(context),
                          decoration: InputDecoration(
       
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: 'Delivery date',
        hintText: 'Delivery Date',
        prefixIcon:const Icon(Icons.calendar_today_rounded),
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Customize focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Customize enabled border color
          ),
        ),
      ),
                          validator: model.validatedeliveryDob,
                          onChanged: model.ondeliveryDobChanged,
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(
                    height: 15,
                  ),
                  CustomDropdownButton2(prefixIcon:Icons.warehouse_outlined,items: model.warehouse, hintText: 'select the warehouse', onChanged: model.setwarehouse, labelText: 'Set Warehouse',value: model.orderdata.setWarehouse,),
                   const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                  initialValue: '${model.orderdata.items?.length ?? 0} items are selected',
                    onTap: () async {
                      if(model.orderdata.customer == null){
                        const snackBar= SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select the customer',style: TextStyle(color: Colors.white,fontSize: 18),),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                        final SelectedItems = await Navigator.pushNamed(
                          context,
                          Routes.itemScreen,
                          arguments: ItemScreenArguments(
                              warehouse: model.orderdata.setWarehouse ?? "",
                              items: model.selectedItems),
                        ) as List<Items>?;
                        if (SelectedItems != null) {
                          Logger().i(SelectedItems.length);
                          // Update the model or perform any actions with the selected items
                          model.setSelectedItems(SelectedItems);
                        }
                    },
                     decoration: InputDecoration(
       suffixIcon: Icon(Icons.arrow_drop_down),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: 'Items',
        hintText: 'For select items click here',
        prefixIcon:const Icon(Icons.shopping_basket),
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Customize focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Customize enabled border color
          ),
        ),
      ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (model.selectedItems.isNotEmpty)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      // Prevent scrolling
                      shrinkWrap: true,
                      itemCount: model.selectedItems.length,
                      itemBuilder: (context, index) {
                        final selectedItem = model.selectedItems[index];
                        return Row(
                          children: [
                            Expanded(flex: 1,child: buildImage(selectedItem.image),),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AutoSizeText(
                                        'ID:  ${selectedItem.itemCode}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          '(${selectedItem.itemName})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                           model.deleteitem(index);
                                          },
                                          icon: const Icon(
                                              Icons.delete_outline_rounded))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const AutoSizeText('Quantity:'),
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle),
                                        onPressed: () {
                                          // Decrease quantity when the remove button is pressed
                                          if (selectedItem.qty != null &&
                                              (selectedItem.qty ?? 0) > 0) {
                                            model.removeitem(index);
                                          }
                                        },
                                      ),
                                      Text(
                                        model
                                            .getQuantity(selectedItem)
                                            .toString(),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle),
                                        onPressed: () {
                                          model.additem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        'Rate: ${selectedItem.rate.toString()}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        'Amount: ${selectedItem.amount?.toString() ?? ""}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  buildbillingsection(model),
                  const SizedBox(
                    height: 25,
                  ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CtextButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.pop(context,const MaterialRoute(page: ListOrderScreen)),
                        ),
                        TextButton(
                          onPressed: () => model.onSavePressed(context),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12)),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            overlayColor: MaterialStateProperty.all(
                                Theme.of(context).badgeTheme.textColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              model.isloading
                                  ? LoadingAnimationWidget.hexagonDots(
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  :  Text(
                                     model.isEdit ?'Update Order' :'Create Order',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget buildImage(String? imageUrl) {
    return Image.network(
      '$baseurl$imageUrl',
    height: 40,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          // Image is done loading
          return child;
        } else {
          // Image is still loading
          return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent));
        }
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // Handle the error by displaying a broken image icon
        return const Center(
            child: Icon(Icons.broken_image_outlined, size: 36.0));
      },
    );
  }

  Widget buildbillingsection(AddOrderViewModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tax and Discount',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow('Total Tax :',
              model.orderdata.totalTaxesAndCharges?.toString() ?? '0.0'),
          buildBillingRow(
              'Subtotal :', model.orderdata.netTotal?.toString() ?? '0.0'),
          buildBillingRow('Discount :',
              model.orderdata.discountAmount?.toString() ?? '0.0'),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Total :', model.orderdata.grandTotal?.toString() ?? '0.0'),
        ],
      ),
    );
  }

  Widget buildBillingRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget buildItemColumn(String labelText, {required String additionalText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(labelText),
        AutoSizeText(additionalText),
      ],
    );
  }
}
