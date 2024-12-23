import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay/domain/states/localization_state.dart';
import 'package:samay/utils/key_words_constants.dart';

class ShowModal {
  static void showSnackBar(
      {required context, required text, bool? error, bool? success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: error == true
              ? Colors.red
              : (success == true ? Colors.green : null),
          content: Text(text)),
    );
  }

  static Future<void> openDialog(
      {required context,
      String title = '',
      String text = '',
      List<Widget>? actions}) async {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    await showCupertinoDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(text),
              actions: actions ??
                  [
                    TextButton(
                        child: Text(
                            localization.translate(KeyWordsConstants.accept)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
            ));
  }
}
