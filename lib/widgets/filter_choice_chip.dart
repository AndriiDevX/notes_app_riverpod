import 'package:flutter/material.dart';
import 'package:notes_app/core/app_colors.dart';

class FilterChoiceChip extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final ValueChanged<bool> onSelected;

  const FilterChoiceChip({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      label: Icon(icon),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: AppColors.chipSelected,
      backgroundColor: AppColors.chipBackground,
    );
  }
}
