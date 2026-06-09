import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

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
      decoration: AppColors.glassCardDecoration,
      child: TextField(
        style: const TextStyle(
          color: AppColors.textPrimaryColor,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          hintText: hintText,
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (searchText) { onChanged(searchText);},
      ),
    );
  }

}