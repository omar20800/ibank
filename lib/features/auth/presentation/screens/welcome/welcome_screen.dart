import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/screens/login/login_screen.dart';
import 'package:ibank/features/auth/presentation/screens/register/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text(AuthConstants.doubletaptoexit),
        duration: Duration(seconds: 1),
        backgroundColor: AppColours.semanticColor1,
      ),
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColours.primaryColor1),
        backgroundColor: AppColours.primaryColor1,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AuthConstants.welcometitle,
                  style: getTitle1TextStyle(color: AppColours.naturalColor6),
                ),
                Text(
                  AuthConstants.welcomesubtitle,
                  style: getTitle3TextStyle(color: AppColours.naturalColor6),
                ),
                Spacer(),
                CustomButtonWidget(
                  text: AuthConstants.signinbutton,
                  bgcolor: AppColours.primaryColor2,
                  textColor: AppColours.naturalColor6,
                  onPressed: () {
                    context.pushTo(LoginScreen());
                  },
                ),
                SizedBox(height: 20),
                CustomButtonWidget(
                  text: AuthConstants.signupbutton,
                  bgcolor: AppColours.naturalColor6,
                  textColor: AppColours.primaryColor1,
                  onPressed: () {
                    context.pushTo(RegisterScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
