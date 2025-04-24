// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/welcome/presentation/screens/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key,required this.maincontext});
  final BuildContext maincontext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColor1,
      appBar: AppBar(
        backgroundColor: AppColours.primaryColor1,
        centerTitle: true,
        title: Text(
          'Settings',
          style: getTitle2TextStyle(color: AppColours.naturalColor6),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AppLocalStorage.removeToken();
              maincontext.pushAndRemoveUntil(WelcomeScreen());
            },
            icon: Icon(Icons.logout, color: AppColours.naturalColor6, size: 30),
          ),
        ],
      ),
    );
  }
}
