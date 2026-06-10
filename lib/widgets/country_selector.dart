import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CountrySelector extends StatelessWidget {

  final String selectedCountry;
  final List<String> countries;
  final ValueChanged<String?> onChanged;

  const CountrySelector({
    super.key,
    required this.selectedCountry,
    required this.countries,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 0,
      ),
      decoration: AppColors.glassCardDecoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCountry,
          dropdownColor: AppColors.backgroundColor,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textPrimaryColor,
          ),
          style: const TextStyle(
            color: AppColors.textPrimaryColor,
          ),
          items: countries.map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}