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
}
