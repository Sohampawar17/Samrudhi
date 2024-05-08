
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CdropDown extends StatelessWidget {
  const CdropDown({
    super.key,
    required this.dropdownButton,
  });

  final Widget dropdownButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).hoverColor,
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),
      child: dropdownButton,
    );
  }
}

class CustomDropdownButton2 extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String hintText;
  final String labelText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final InputDecoration? searchInputDecoration;
  final Widget? searchInnerWidget;
  final double? searchInnerWidgetHeight;
  final TextEditingController? searchController;
  final IconData? prefixIcon;
 
  const CustomDropdownButton2({super.key, 
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.searchInputDecoration,
    this.searchInnerWidget,
    this.searchInnerWidgetHeight,
    this.searchController, this.prefixIcon,required  this.labelText, this.validator,
  });
 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
     height:60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
      
        border: Border.all(
          width: 1,
         color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownSearch<String>(
              popupProps:  PopupProps.bottomSheet(
                fit: FlexFit.tight,
                constraints: BoxConstraints(maxHeight: 600),
showSearchBox: true,showSelectedItems: true,searchFieldProps: TextFieldProps(
  decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),

        hintText: 'search here....',
        prefixIcon: Icon(Icons.search),
        labelStyle: const TextStyle(
          color: Colors.blue, // Customize label text color
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
 itemBuilder: (
          BuildContext context,
          String? item,
          bool isSelected,
        ) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:Container(
            width: 20, // Adjust the width as needed
            height: 20, // Adjust the height as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
               
                width: 1.0,
              ),
              color: isSelected ? Colors.blueAccent : Colors.transparent,
            ),
          ),
                  ),
                         Expanded(
                          flex: 6,
                           child: ListTile(
                                           title: Text(
                                             item ?? '',
                                             style: TextStyle(
                                               fontWeight: FontWeight.w500,
                                               color: isSelected ? Colors.blue : Colors.black,
                                             ),
                                           ),
                                           selected: isSelected,
                                         ),
                         ),
                ],
              ),
             
              const Divider(
             thickness: 1,
                color: Colors.black45,
              ),
            ],
          );
        },
              ),

              items:items,
              dropdownDecoratorProps:  DropDownDecoratorProps(
          dropdownSearchDecoration:InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: InputBorder.none
      ),
              ),
              onChanged: onChanged,
              selectedItem:value,
        validator: validator,
          ),
        
    );
  }
}


class CustomModelDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String hintText;
  final String labelText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final InputDecoration? searchInputDecoration;
  final Widget? searchInnerWidget;
  final double? searchInnerWidgetHeight;
  final TextEditingController? searchController;
  final IconData? prefixIcon;

  final Widget Function(BuildContext context, T? item, bool isSelected) itemBuilder;

  const CustomModelDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.searchInputDecoration,
    this.searchInnerWidget,
    this.searchInnerWidgetHeight,
    this.searchController,
    this.prefixIcon,
    required this.labelText,
    this.validator,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          width: 1,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownSearch<T>(
        popupProps: PopupProps.bottomSheet(
          fit: FlexFit.tight,
          constraints: BoxConstraints(maxHeight: 600),
          showSearchBox: true,
          showSelectedItems: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              hintText: 'Search here....',
              prefixIcon: Icon(Icons.search),
              labelStyle: const TextStyle(
                color: Colors.blue, // Customize label text color
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
        
        itemBuilder: (
          BuildContext context,
          T? item,
          bool isSelected,
        ) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        color: isSelected ? Colors.blueAccent : Colors.transparent,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListTile(
                      title: itemBuilder(context, item, isSelected),
                      selected: isSelected,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 0.5,
                color: Colors.black45,
              ),
            ],
          );
        },),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            labelStyle: const TextStyle(
              color: Colors.black54, // Customize label text color
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: const TextStyle(
              color: Colors.grey, // Customize hint text color
            ),
            border: InputBorder.none,
          ),
        ),
        onChanged: onChanged,
        selectedItem: value,
        validator: validator,
      ),
    );
  }
}


