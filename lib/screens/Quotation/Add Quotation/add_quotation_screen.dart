import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/addquotation_model.dart';
import '../../../router.router.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_quotation_viewmodel.dart';

class AddQuotationView extends StatefulWidget {

  final String quotationid;
  const AddQuotationView({super.key, required this.quotationid});

  @override
  State<AddQuotationView> createState() => _AddQuotationViewState();
}

class _AddQuotationViewState extends State<AddQuotationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddQuotationModel>.reactive(
      viewModelBuilder: () => AddQuotationModel(),
      onViewModelReady: (model) => model.initialise(context, widget.quotationid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.quotationdata.name ?? "")
              : const Text('Create Quotation'),
          leading: IconButton.outlined(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.listQuotationScreen);
            },
            icon: const Icon(Icons.arrow_back),
          ),
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

                  CustomDropdownButton2(
                    value: model.quotationdata.quotationTo,
                    prefixIcon: Icons.person_2,
                    items: model.quotationto,
                    hintText: 'Select Quotation To',
                    labelText: 'Quotation To',
                    onChanged: model.setquotationto,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropdownButton2(
                    value: model.quotationdata.partyName,
                    prefixIcon: Icons.person_2,
                    items: model.searchcustomer,
                    hintText: 'Select the customer',

                    labelText: model.customerLabel,
                    onChanged: model.setcustomer,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomSmallTextFormField(prefixIcon: Icons.person_pin,controller: model.customernamecontroller,labelText:'Party Name' ,hintText: 'Enter the Party'),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomDropdownButton2(
                          value: model.quotationdata.orderType,
                          items: model.ordetype,
                          hintText: 'select the order type',
                          onChanged: model.setordertype,
                          labelText: 'Order Type',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          readOnly: true,
                          controller: model.validtilldatecontroller,
                          onTap: () => model.selectvalidtillDate(context),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            labelText: 'Valid till Date',
                            hintText: 'Valid till Date',
                            prefixIcon:
                                const Icon(Icons.calendar_today_rounded),
                            labelStyle: const TextStyle(
                              color:
                                  Colors.black54, // Customize label text color
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
                                color: Colors
                                    .blue, // Customize focused border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: const BorderSide(
                                color: Colors
                                    .grey, // Customize enabled border color
                              ),
                            ),
                          ),
                         // validator: model.validatedeliveryDob,
                          onChanged: model.onvalidtillDobChanged,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // TextFormField(
                  //   readOnly: true,
                  //   onTap: () async {
                  //     final SelectedItems = await Navigator.pushNamed(
                  //       context,
                  //       Routes.quotationItemScreen,
                  //        arguments:QuotationItemScreenArguments(items: model.selectedItems),
                  //       // arguments: ItemScreenArguments(
                  //       // //     warehouse: model.orderdata.setWarehouse ?? "",
                  //       //     items: model.selectedItems),
                  //     ) as List<Items>?;
                  //     if (SelectedItems != null) {
                  //       Logger().i(SelectedItems.length);
                  //
                  //       // Update the model or perform any actions with the selected items
                  //       model.setSelectedItems(SelectedItems);
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 12.0),
                  //     //
                  //     // labelText: selectedItems.isEmpty
                  //     //     ? 'Items'
                  //     //     : 'Selected ${selectedItems.length} item(s)',
                  //
                  //     labelText: 'Items',
                  //     hintText: 'For select items click here',
                  //     prefixIcon: const Icon(Icons.shopping_basket),
                  //     labelStyle: const TextStyle(
                  //       color: Colors.black54, // Customize label text color
                  //       fontSize: 16.0,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     hintStyle: const TextStyle(
                  //       color: Colors.grey, // Customize hint text color
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.blue, // Customize focused border color
                  //       ),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.grey, // Customize enabled border color
                  //       ),
                  //     ),
                  //   ),
                  // ),


                  //
                  // TextFormField(
                  //   controller: model.itemController,
                  //   readOnly: true,
                  //   onTap: () async {
                  //     final selectedItems = await Navigator.pushNamed(
                  //       context,
                  //       Routes.quotationItemScreen,
                  //       arguments: QuotationItemScreenArguments(items: model.selectedItems),
                  //     ) as List<Items>?;
                  //
                  //     if (selectedItems != null) {
                  //       Logger().i(selectedItems.length);
                  //
                  //       // Update the model or perform any actions with the selected items
                  //       model.setSelectedItems(selectedItems);
                  //
                  //       // Update the value of the TextFormField
                  //       final selectedItemsValue = selectedItems.isEmpty
                  //           ? ''
                  //           : 'Selected ${selectedItems.length} item(s)';
                  //       model.itemController.text = selectedItemsValue;
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 12.0),
                  //     labelText: 'Items',
                  //     hintText: 'For select items click here',
                  //     prefixIcon: const Icon(Icons.shopping_basket),
                  //     labelStyle: const TextStyle(
                  //       color: Colors.black54, // Customize label text color
                  //       fontSize: 16.0,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     hintStyle: const TextStyle(
                  //       color: Colors.grey, // Customize hint text color
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.blue, // Customize focused border color
                  //       ),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.grey, // Customize enabled border color
                  //       ),
                  //     ),
                  //   ),
                  // ),





                  TextFormField(
                    readOnly: true,
                    initialValue: '${model.selectedItems.length} items selected',
                    onTap: () async {
                      final SelectedItems = await Navigator.pushNamed(
                        context,
                        Routes.quotationItemScreen,
                        arguments: QuotationItemScreenArguments(items: model.selectedItems),
                      ) as List<Items>?;

                      if (SelectedItems != null) {
                        Logger().i(SelectedItems.length);

                        // Update the model or perform any actions with the selected items
                        model.setSelectedItems(SelectedItems);

                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      labelText: 'Items',
                      hintText: 'For select items click here',
                      prefixIcon: const Icon(Icons.shopping_basket),
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
                            Expanded(
                              flex: 1,
                              child: buildImage(selectedItem.image),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Row(
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
                                    mainAxisSize: MainAxisSize.min,
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
                        onPressed: () => Navigator.of(context).pop(),
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
                                : Text(
                                    model.isEdit
                                        ? 'Update Order'
                                        : 'Create Order',
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

  Widget buildbillingsection(AddQuotationModel model) {
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
              model.quotationdata.totalTaxesAndCharges?.toString() ?? '0.0'),
          buildBillingRow(
              'Subtotal :', model.quotationdata.netTotal?.toString() ?? '0.0'),
          buildBillingRow('Discount :',
              model.quotationdata.discountAmount?.toString() ?? '0.0'),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Total :', model.quotationdata.grandTotal?.toString() ?? '0.0'),
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

