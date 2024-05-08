import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String hintText;
  final String labelText;
  final void Function(T?)? onChanged;

  CustomDropdown({
    required this.items,
    required this.hintText,
    required this.labelText,
    this.value,
    this.onChanged,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDropdown(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedItem?.toString() ?? widget.hintText),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.labelText),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ListTile(
                  title: Text(item.toString()),
                  onTap: () {
                    setState(() {
                      _selectedItem = item;
                    });
                    Navigator.of(context).pop();
                    widget.onChanged?.call(item);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}