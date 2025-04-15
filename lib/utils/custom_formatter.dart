import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class CustomFormatter extends TextInputFormatter {
  // The pattern to match against to determine the input type
  static final _pattern = RegExp(r'^\d*\.?\d*$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric or non-decimal characters
    final strippedValue = newValue.text.replaceAll(RegExp(r'[^\d\.]'), '');

    // Check if the stripped value matches our pattern
    if (!_pattern.hasMatch(strippedValue)) {
      // If the input does not match our pattern, return the old value
      return oldValue;
    }

    // Split the stripped value into integer and fractional parts
    final parts = strippedValue.split('.');

    String formattedValue = '';

    // Add comma separators to the integer part, if it exists
    if (parts.isNotEmpty) {
      formattedValue = NumberFormat('#,##0', 'en_US').format(int.parse(parts[0]));
    }

    // Add decimal point and decimal places, if the fractional part exists
    if (parts.length > 1) {
      formattedValue += '.${parts[1]}';
    }

    // Determine the new cursor position based on the length difference between the old and new text values
    final lengthDiff = formattedValue.length - newValue.text.length;
    final newSelectionEnd = (newValue.selection.end) + lengthDiff;

    // Return the formatted value as the new value with the updated cursor position
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: newSelectionEnd),
    );
  }
}
