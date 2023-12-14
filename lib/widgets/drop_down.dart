
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
    this.searchController, this.prefixIcon,required  this.labelText,
  });
 

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
      child: DropdownSearch<String>(
              popupProps:  PopupProps.bottomSheet(
                fit: FlexFit.tight,
                constraints: BoxConstraints(maxHeight: 400),
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
)
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
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(18.0),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(18.0),
        //   borderSide: const BorderSide(
        //     color: Colors.blue, // Customize focused border color
        //   ),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(18.0),
        //   borderSide: const BorderSide(
        //     color: Colors.grey, // Customize enabled border color
        //   ),
        // ),
      ),
              ),
              onChanged: onChanged,
              selectedItem:value,
          ),
        
    );
  }
}
