import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/auth/presentation/screens/register/register_screen.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColours.primaryColor1,
        appBar: AppBar(
          backgroundColor: AppColours.primaryColor1,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColours.naturalColor6),
          ),
          title: Text(
            AuthConstants.logintitle,
            style: getTitle2TextStyle(color: AppColours.naturalColor6),
          ),
        ),
        body: Form(
          key: _formKey,
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthError) {
                context.pop();
                Dialogs.showErrorDialog(context, state.errorMessage);
              } else if (state is AuthSuccess) {
                context.pop();
                context.pushAndRemoveUntil(MainScreen());
              } else if (state is AuthLoading) {
                Dialogs.showLoadingDialog(context);
              }
            },
            builder: (context, state) {
              var cubit = context.read<AuthCubit>();
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColours.naturalColor6,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                margin: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthConstants.loginwelcome,
                        style: getTitle1TextStyle(
                          color: AppColours.primaryColor1,
                        ),
                      ),
                      Text(
                        AuthConstants.logindescription,
                        style: getCaption2TextStyle(),
                      ),
                      const SizedBox(height: 20),
                      Center(child: Image.asset(AuthAssets.loginlogo)),
                      const SizedBox(height: 20),
                      InputFieldWidget(
                        hint: AuthConstants.emailhint,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      InputFieldWidget(
                        hint: AuthConstants.passwordhint,
                        keyboardType: TextInputType.number,
                        controller: passwordController,
                        isPassword: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AuthConstants.forgotpassword,
                              style: getCaption2TextStyle(
                                color: AppColours.primaryColor1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login(
                              emailController!.text.trim(),
                              passwordController!.text.trim(),
                            );
                          }
                        },
                        text: AuthConstants.signinbutton,
                      ),
                      Spacer(),
                      Center(child: Image.asset(AuthAssets.biometriclogo)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AuthConstants.donthaveaccount,
                            style: getCaption2TextStyle(),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushReplacement(RegisterScreen());
                            },
                            child: Text(
                              AuthConstants.signupbutton,
                              style: getCaption2TextStyle(
                                color: AppColours.primaryColor1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
