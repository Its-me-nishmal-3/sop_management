import 'package:flutter/material.dart';
import 'package:ozole/core/constants/app_colors.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixText: "+91 ",
        prefixStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        hintText: "Number",
      ).copyWith(
        // Apply properties from the theme manually
        labelStyle: inputTheme.labelStyle,
        hintStyle: inputTheme.hintStyle,
        enabledBorder: inputTheme.enabledBorder,
        focusedBorder: inputTheme.focusedBorder,
        border: inputTheme.border,
        contentPadding: inputTheme.contentPadding,
      ),
    );
  }
}
