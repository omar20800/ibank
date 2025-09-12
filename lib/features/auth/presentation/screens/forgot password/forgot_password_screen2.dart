import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/core/widgets/otp_widget.dart';
import 'package:ibank/features/auth/presentation/screens/forgot%20password/forgot_password_screen3.dart';

class ForgotPasswordScreen2 extends StatelessWidget {
  ForgotPasswordScreen2({super.key});
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: getTitle2TextStyle()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColours.naturalColor6,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [getDefaultBoxShadow2()],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'enter the otp code we sent to your email',
                      style: getCaption1TextStyle(
                        color: AppColours.naturalColor3,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    otpWidget(otpController: otpController),
                    SizedBox(height: 16.0),
                    Text(
                      'We sent you an otp code to verify your email',
                      style: getBody3TextStyle(color: AppColours.naturalColor1),
                    ),
                    SizedBox(height: 24.0),
                    CustomButtonWidget(
                      text: "Verify",
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
