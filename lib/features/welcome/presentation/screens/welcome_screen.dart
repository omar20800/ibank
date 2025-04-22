import 'package:flutter/material.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/auth/presentation/screens/login/login_screen.dart';
import 'package:ibank/features/auth/presentation/screens/register/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColours.primaryColor1),
      backgroundColor: AppColours.primaryColor1,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to iBank',
                style: getTitle1TextStyle(color: AppColours.naturalColor6),
              ),
              Text(
                'Your digital banking solution',
                style: getTitle3TextStyle(color: AppColours.naturalColor6),
              ),
              Spacer(),
              CustomButtonWidget(
                text: 'Sign In',
                bgcolor: AppColours.primaryColor2,
                textColor: AppColours.naturalColor6,
                onPressed: () {
                  context.pushTo(LoginScreen());
                },
              ),
              SizedBox(height: 20),
              CustomButtonWidget(
                text: 'Sign Up',
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
    );
  }
}
