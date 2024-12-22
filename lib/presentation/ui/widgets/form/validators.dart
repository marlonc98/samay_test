import 'package:provider/provider.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/presentation/ui/widgets/form/key_words_validators.dart';
import 'package:samay/utils/currency_format.dart';

enum FormType {
  double,
  number,
  text,
  phone,
  email,
  textarea,
  yesNot,
  date,
  dropdown,
  password,
  checkbox,
  chipOne,
  chipMany,
  multipleImages,
  image,
  radioSearcher,
  multipleSearcher,
  currency,
  maps,
}

class Validators {
  static String? checkMinlength(
      {required String? text, required minLength, required context}) {
    if (text == null || text.length < minLength) {
      final localization =
          Provider.of<LocalizationState>(context, listen: false);
      return localization.translate(KeyWordsValidators.validatorMinlength,
          values: {'minLength': minLength});
    }
    return null;
  }

  static String? checkMaxLength({
    required dynamic text,
    required int maxLength,
    required context,
  }) {
    if (text.length > maxLength) {
      final localization =
          Provider.of<LocalizationState>(context, listen: false);
      return localization.translate(KeyWordsValidators.validatorMaxLength,
          values: {'maxLength': maxLength});
    }
    return null;
  }

  static String? checkRequired({required dynamic text, required context}) {
    if (text == null || text == '' || (text is List && text.isEmpty)) {
      final localization =
          Provider.of<LocalizationState>(context, listen: false);
      return localization.translate(KeyWordsValidators.validatorRequired);
    }
    return null;
  }

  static String? checkIfIsNumber(
      {required dynamic text, required context, FormType? type}) {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    if (text != null &&
        text.length > 0 &&
        type == FormType.currency &&
        CurrencyFormat.usdToInt(text) == null) {
      return localization.translate(KeyWordsValidators.validatorIsNotNumber);
    } else if (text != null &&
        text.length > 0 &&
        type != FormType.currency &&
        double.tryParse(text)?.toInt() == null) {
      return localization.translate(KeyWordsValidators.validatorIsNotNumber);
    }
    return null;
  }

  static String? checkIfIsDouble({required dynamic text, required context}) {
    if (text != null && text.length > 0 && double.tryParse(text) == null) {
      final localization =
          Provider.of<LocalizationState>(context, listen: false);
      return localization.translate(KeyWordsValidators.validatorIsNotDouble);
    }
    return null;
  }

  static String? chsckIfIsGreaterThan(
      {required dynamic text, required int value, required context}) {
    if (text != null && text.length > 0 && double.tryParse(text) != null) {
      if (double.parse(text) < value) {
        final localization =
            Provider.of<LocalizationState>(context, listen: false);
        return localization.translate(KeyWordsValidators.validatorIsGreaterThan,
            values: {'value': value});
      }
    }
    return null;
  }

  static String? check(
      {bool isEmail = false,
      bool required = false,
      int? minLength,
      int? maxLength,
      int? minValue,
      int? maxValue,
      int? minArrayLength,
      FormType? type,
      String? matchFieldName,
      String? matchFieldKey,
      List<RegexFormError>? regexs,
      bool? atLeastOneLowercase,
      bool? atLeastOneUppercase,
      bool? atLeastOneNumber,
      required dynamic text,
      required context}) {
    if (required) {
      String? check = Validators.checkRequired(text: text, context: context);
      if (check != null) return check;
    }
    if (minLength != null) {
      String? check = Validators.checkMinlength(
          text: text, context: context, minLength: minLength);
      if (check != null) return check;
    }
    if (minValue != null) {
      String? check =
          Validators.checkIfIsNumber(text: text, context: context, type: type);
      if (check != null) return check;
      double? parsedValue = type == FormType.currency
          ? CurrencyFormat.usdToInt(text)?.toDouble()
          : double.tryParse(text);
      if (parsedValue != null && parsedValue < minValue) {
        final localization =
            Provider.of<LocalizationState>(context, listen: false);
        if (type == FormType.currency) {
          return localization.translate(KeyWordsValidators.validatorMinValue,
              values: {'minValue': CurrencyFormat.formatCurrency(minValue)});
        }
        return localization.translate(KeyWordsValidators.validatorMinValue,
            values: {'minValue': minValue});
      }
    }
    if (maxValue != null) {
      String? check =
          Validators.checkIfIsNumber(text: text, context: context, type: type);
      if (check != null) return check;
      double? parsedValue = type == FormType.currency
          ? CurrencyFormat.usdToInt(text)?.toDouble()
          : double.tryParse(text);
      if (parsedValue != null && parsedValue > maxValue) {
        final localization =
            Provider.of<LocalizationState>(context, listen: false);
        if (type == FormType.currency) {
          return localization.translate(KeyWordsValidators.validatorMaxValue,
              values: {'maxValue': CurrencyFormat.formatCurrency(maxValue)});
        } else {
          return localization.translate(KeyWordsValidators.validatorMaxValue,
              values: {'maxValue': maxValue});
        }
      }
    }
    if (maxLength != null) {
      String? check =
          checkMaxLength(text: text, maxLength: maxLength, context: context);
      if (check != null) return check;
    }
    if (type == FormType.number) {
      String? check = checkIfIsNumber(text: text, context: context);
      if (check != null) return check;
    }
    if (type == FormType.double) {
      String? check = checkIfIsDouble(text: text, context: context);
      if (check != null) return check;
    }
    return null;
  }
}

class RegexFormError {
  RegExp regExp;
  String error;

  RegexFormError({
    required this.regExp,
    required this.error,
  });
}
