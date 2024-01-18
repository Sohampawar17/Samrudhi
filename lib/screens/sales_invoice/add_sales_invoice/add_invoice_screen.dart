import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/model/add_invoice_model.dart';
import 'package:geolocation/screens/sales_invoice/add_sales_invoice/add_invoice_viewmodel.dart';
import 'package:geolocation/screens/sales_invoice/list_sales_invoice/list_sales_invoice_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../../constants.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';


class AddInvoiceScreen extends StatefulWidget {
  final String invoiceid;
  const AddInvoiceScreen({super.key, required this.invoiceid});
  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddInvoiceViewModel>.reactive(
      viewModelBuilder: () => AddInvoiceViewModel(),
      onViewModelReady: (model) => model.initialise(context, widget.invoiceid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.invoiceData.name ?? "")
              : const Text('Create Invoice'),
          leading: IconButton.outlined(
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.listInvoiceScreen);
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
                  CustomDropdownButton2(value: model.invoiceData.customer,prefixIcon: Icons.person_2,items: model.searchcutomer, hintText: 'Select the customer', labelText: 'Customer', onChanged:  model.setcustomer,),

                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: model.deliverydatecontroller,
                    onTap: () => model.selectdeliveryDate(context),
                    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: 'Payment Due Date',
        hintText: 'Payment Due Date',
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
                  const SizedBox(
                    height: 15,
                  ),
              CheckboxListTile(
                value: model.updateStock,
                onChanged: model.setStock,
                title: Text(
                  'Update Stock',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54, // Customize the text color
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                 // Customize the background color

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black38, width: 1), // Add border for styling
                ),
                activeColor: Colors.blue, // Color when the checkbox is checked
                checkColor: Colors.white, // Color of the check icon
              ),
                  const SizedBox(
                    height: 15,
                  ),
              CustomDropdownButton2(prefixIcon:Icons.warehouse_outlined,items: model.warehouse, hintText: 'select the warehouse', onChanged: model.setwarehouse, labelText: 'Set Warehouse',value: model.invoiceData.setWarehouse,),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    readOnly: true,
                  key:Key(model.displayString),
                  initialValue: model.displayString,
                    onTap: () async {
                      if(model.invoiceData.customer == null){
                        const snackBar= SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select the customer ',style: TextStyle(color: Colors.white,fontSize: 18),),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                        final SelectedItems = await Navigator.pushNamed(
                          context,
                          Routes.invoiceItemScreen,
                          arguments: InvoiceItemScreenArguments(
                              invoiceItems: model.selectedItems, warehouse: model.invoiceData.setWarehouse ?? '' ),
                        ) as List<InvoiceItems>?;
                        if (SelectedItems != null) {
                          model.selectedItems.clear();
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
                                              (selectedItem.qty ?? 0) > 1) {
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
                  // if(model.invoiceData.docstatus != 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CtextButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.pop(context,const MaterialRoute(page: ListInvoiceScreen)),
                        ),
                        model.isSame == false?
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
                             Text(
                                     model.isEdit ?'Update Invoice' :'Create Invoice',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                            ],
                          ),
                        ):
                        TextButton(
                          onPressed: () => model.onSubmitPressed(context),
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
                             Text(
                                'Submit Invoice',
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

  Widget buildbillingsection(AddInvoiceViewModel model) {
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
          buildBillingRow(
              'Subtotal :', model.invoiceData.netTotal?.toString() ?? '0.0'),
          SizedBox(height: 10,),
          buildBillingRow('Total Tax :',
              model.invoiceData.totalTaxesAndCharges?.toString() ?? '0.0'),
          SizedBox(height: 10,),
          buildBillingRow('Discount :',
              model.invoiceData.discountAmount?.toString() ?? '0.0'),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Total :', model.invoiceData.grandTotal?.toString() ?? '0.0'),
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
