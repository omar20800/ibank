import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/otp_widget.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/auth/presentation/screens/forgot%20password/forgot_password_screen3.dart';

class ForgotPasswordScreen2 extends StatelessWidget {
  ForgotPasswordScreen2({super.key, required this.email});
  final String email;
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password', style: getTitle2TextStyle()),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is AuthLoading) {
              Dialogs.showLoadingDialog(context);
            } else if (state is AuthError) {
              context.pop();
              Dialogs.showErrorSnackbar(context, state.errorMessage);
            } else if (state is AuthOtpVerified) {
              context.pop();
              context.pushTo(ForgotPasswordScreen3(email: email,otp: otpController.text.trim(),));
            }
            },
          builder: (context, state) {
            return Padding(
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
                            style: getBody3TextStyle(
                              color: AppColours.naturalColor1,
                            ),
                          ),
                          SizedBox(height: 24.0),
                          CustomButtonWidget(text: "Verify", onPressed: () {
                            context.read<AuthCubit>().passwordOTPVerify(
                                  email,
                                  otpController.text.trim(),
                                );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
