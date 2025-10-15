import 'package:flutter/material.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/screens/welcome/welcome_screen.dart';

class ChangePasswordSuccess extends StatelessWidget {
  const ChangePasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AuthConstants.changePasswordAppbarTitle, style: getTitle2TextStyle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AuthAssets.passwordillustration),
              SizedBox(height: 20.0),
              Text(
                AuthConstants.changePasswordSuccessMessage,
                style: getTitle3TextStyle(color: AppColours.primaryColor1),
              ),
              SizedBox(height: 20.0),
              Text(
                AuthConstants.changePasswordSuccessDescription,
                style: getBody3TextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              CustomButtonWidget(
                text: AuthConstants.backToLoginButton,
                onPressed: () {
                  context.pushAndRemoveUntil(WelcomeScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
