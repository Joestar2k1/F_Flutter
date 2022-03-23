import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key key, this.types, this.title}) : super(key: key);
  final List<String> types;
  final String title;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
            isExpanded: true,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).hintColor,
            ),
            hint: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).hintColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            items: widget.types
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedItem,
            onChanged: (value) {
              setState(() {
                selectedItem = value as String;
              });
            },
            buttonHeight: 50,
            buttonWidth: 150,
            itemHeight: 50,
            buttonElevation: 2,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0)),
      ),
    );
  }
}
