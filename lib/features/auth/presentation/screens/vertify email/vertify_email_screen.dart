import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/functions/validation.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/core/widgets/otp_widget.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';
import 'package:pinput/pinput.dart';

class VertifyEmailScreen extends StatefulWidget {
  const VertifyEmailScreen({super.key, required this.email});
  final String email;

  @override
  State<VertifyEmailScreen> createState() => _VertifyEmailScreenState();
}

class _VertifyEmailScreenState extends State<VertifyEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController? otpController = TextEditingController();

  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: Scaffold(
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
            'Vertify Email',
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
              } else if (state is AuthOtpVerified) {
                context.pop();
                context.pushAndRemoveUntil(MainScreen());
              } else if (state is AuthLoading) {
                Dialogs.showLoadingDialog(context);
              }
            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
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
                              'Verify Your Email',
                              style: getTitle1TextStyle(
                                color: AppColours.primaryColor1,
                              ),
                            ),
                            Text(
                              'Enter the verification code we just sent on your email address.',
                              style: getCaption2TextStyle(),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.email,
                              style: getCaption2TextStyle(
                                color: AppColours.primaryColor1,
                              ),
                            ),
                            const SizedBox(height: 20),
                            otpWidget(otpController: otpController),
                            const SizedBox(height: 20),
                            CustomButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().verifyEmail(
                                    widget.email,
                                    otpController!.text.trim(),
                                  );
                                }
                              },
                              text: 'Verify',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
