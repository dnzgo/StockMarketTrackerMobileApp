import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget{
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (searchText) { onChanged(searchText);},
      ),
    );
  }

}