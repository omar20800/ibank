// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class SettingsListWidget extends StatelessWidget {
  SettingsListWidget({super.key});

  final List<String> settingsList = [
    'Change Password',
    'Touch ID',
    'Languages',
    'App information',
    'Customer care',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 10.h),
              Divider(color: AppColours.naturalColor4, thickness: 1),
            ],
          );
        },
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(settingsList[index], style: getBody1TextStyle()),
              Spacer(),
              index == 4
                  ? Text(
                    '19008989',
                    style: getCaption1TextStyle(
                      color: AppColours.naturalColor3,
                    ),
                  )
                  : Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColours.naturalColor4,
                  ),
            ],
          );
        },
      ),
    );
  }
}
