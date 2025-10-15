import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/auth/presentation/screens/forgot%20password/forgot_password_screen2.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AuthConstants.forgotPasswordAppbarTitle, style: getTitle2TextStyle()),
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
            } else if (state is PasswordResetEmailSent) {
              context.pop();
              context.pushTo(ForgotPasswordScreen2(email: state.email));
              
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
                            AuthConstants.forgotPasswordMessage,
                            style: getCaption1TextStyle(
                              color: AppColours.naturalColor3,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          InputFieldWidget(
                            hint: AuthConstants.emailhint,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            AuthConstants.sendOtpMessage,
                            style: getBody3TextStyle(
                              color: AppColours.naturalColor1,
                            ),
                          ),
                          SizedBox(height: 24.0),
                          CustomButtonWidget(text: AuthConstants.sendButton, onPressed: () {
                            context.read<AuthCubit>().requestPasswordReset(emailController.text.trim());
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
