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
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: getCaption2TextStyle(color: AppColours.primaryColor1),
                ),
              ),
            ],
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
