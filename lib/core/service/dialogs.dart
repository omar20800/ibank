import 'package:flutter/material.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class Dialogs {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColours.naturalColor6,
            title: Text(
              'Error',
              style: getTitle2TextStyle(color: AppColours.semanticColor1),
            ),
            content: Text(
              message,
              style: getCaption2TextStyle(color: AppColours.textColor),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'OK',
                  style: getCaption2TextStyle(color: AppColours.primaryColor1),
                ),
              ),
            ],
          ),
    );
  }

  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    Function? onAction1Pressed,
    Function? onAction2Pressed,
    required String action1Text,
    required String action2Text,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                  if (onAction1Pressed != null) {
                    onAction1Pressed();
                  }
                },
                child: Text(action1Text),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  if (onAction2Pressed != null) {
                    onAction2Pressed();
                  }
                },
                child: Text(action2Text),
              ),
            ],
          ),
    );
  }

  static void showInfoDialog(
    BuildContext context,
    String message,
    Function? onOkPressed,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColours.naturalColor6,
            title: Text(
              'Info',
              style: getTitle2TextStyle(color: AppColours.primaryColor1),
            ),
            content: Text(
              message,
              style: getCaption2TextStyle(color: AppColours.textColor),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  if (onOkPressed != null) {
                    onOkPressed();
                  }
                },
                child: Text(
                  'OK',
                  style: getCaption2TextStyle(color: AppColours.primaryColor1),
                ),
              ),
            ],
          ),
    );
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: getCaption2TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColours.semanticColor1,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: getCaption2TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColours.semanticColor4,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showLoadingDialog(
    BuildContext context, {
    String message = "Loading...",
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 100,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: AppColours.primaryColor1,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        message,
                        style: getCaption2TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
