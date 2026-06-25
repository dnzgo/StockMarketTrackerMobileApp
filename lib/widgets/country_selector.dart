import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CountrySelector extends StatelessWidget {
  /*
  Country selector shows selected country, when clicked shows countries list and when a new country selected shows it as default
  */
  final String selectedCountry;
  final Map<String, String> countries;
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
        horizontal: 5,
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

          selectedItemBuilder: (context) {
            return countries.entries.map((entry) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.public,
                    size: 14,
                    color: AppColors.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(entry.key),
                ],
              );
            }).toList();
          },

          items: countries.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}