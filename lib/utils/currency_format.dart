import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  static String formatCurrency(int value) {
    final formattedAmount = NumberFormat("#,##0", "es_CO").format(value);
    return formattedAmount;
  }

  static String formatWithSimbolCurrency(int value) {
    final formattedAmount = NumberFormat('\$#,##0', 'es_CO').format(value);
    return formattedAmount;
  }

  static int? usdToInt(String value) {
    final removeDotsAndCommas = value.replaceAll('.', '').replaceAll(',', '');
    final removeDollarSign = removeDotsAndCommas.replaceAll('\$', '');
    final int? parsedValue = int.tryParse(removeDollarSign);
    return parsedValue;
  }

  static String? formatCurrencyString(String value) {
    int parsed;
    try {
      parsed = int.parse(value);
    } catch (_) {
      return null;
    }
    final formattedAmount = NumberFormat("#,##0", "es_CO").format(parsed);
    return formattedAmount;
  }

  static void loadControllerCurrency(
      TextEditingController controller, int? oldVal) {
    if (controller.text.length >= 13) {
      controller.text = controller.text.substring(0, 13);
    }
    TextSelection selection = controller.selection;
    String text = CurrencyFormat.usdToInt(controller.text).toString();
    if (text.isEmpty || text == "null") {
      controller.clear();
      return;
    }
    bool wasDeleted = text.length < oldVal.toString().length;
    if (CurrencyFormat.formatCurrencyString(text) != null) {
      text = CurrencyFormat.formatCurrencyString(text)!;
    }
    if (controller.text != text) {
      controller.text = text;
    }
    if (!wasDeleted &&
        selection.baseOffset % 4 == 0 &&
        selection.baseOffset != 0) {
      //move offset one to right
      selection = TextSelection.fromPosition(
          TextPosition(offset: selection.baseOffset + 1));
    } else if (wasDeleted &&
        selection.baseOffset % 4 == 0 &&
        selection.baseOffset != 0) {
      //move offset one to left
      selection = TextSelection.fromPosition(
          TextPosition(offset: selection.baseOffset - 1));
    }
    controller.selection = selection;
  }
}
