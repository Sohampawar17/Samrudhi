import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/add_order_model.dart';
import 'add_item_model.dart';

class ItemScreen extends StatelessWidget {
  final String warehouse;
  final List<Items> items;

  const ItemScreen({super.key, required this.warehouse, required this.items});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemListModel>.reactive(
      viewModelBuilder: () => ItemListModel(),
      onViewModelReady: (model) => model.initialise(context, warehouse, items),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Select Items'),
          ),
          body: fullScreenLoader(
            loader: model.isBusy,
            context: context,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSmallTextFormField(controller: model.searchController, labelText: 'Search', hintText: 'Type here to search',onChanged: model.searchItems,), ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: model.filteredItems.length,
              itemBuilder: (context, index) {
                final selectedItem = model.filteredItems[index];
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  tileColor: model.isSelected(selectedItem) ? Colors.blue.shade200 : Colors.white10,
                  value: model.isSelected(selectedItem),
                  onChanged: (bool? value) {
                    model.toggleSelection(selectedItem);
                  },
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${selectedItem.itemCode} (${selectedItem.itemName})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4), // Adjust the height as needed
                      Row(
                        children: [
                          Expanded(flex: 2,child: const AutoSizeText('Quantity:')),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                if (selectedItem.qty != null && (selectedItem.qty ?? 0.0) > 0.0) {
                                  model.removeitem(index);
                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              model.getQuantity(selectedItem).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () {
                                model.additem(index);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4), // Adjust the height as needed
                      AutoSizeText(
                        'Actual Quantity: ${selectedItem.actualQty}',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1,);
              },
            )
]
            ),
            ),
          ),
          bottomSheet: BottomSheetWidget(
            model: model,
          )),
    );
  }

  Widget buildImage(String? imageUrl) {
    return Image.network(
      '$baseurl$imageUrl',
      height: 36,
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
        return const Icon(Icons.broken_image,size: 36,);
      },
    );
  }

  Widget buildItemColumn(String label, {String? additionalText}) {
    return Column(
      children: [
        AutoSizeText(label),
        if (additionalText != null) AutoSizeText(additionalText),
      ],
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  final ItemListModel model;

  const BottomSheetWidget({super.key, required this.model});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white38,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white38,
            ),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context, widget.model.isSelecteditems);
                },
                minWidth: 200.0,
                height: 48.0,
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
