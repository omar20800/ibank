import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/core/widgets/input_field_widget.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/auth/presentation/screens/login/login_screen.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController? nameController = TextEditingController();

  final TextEditingController? emailController = TextEditingController();

  final TextEditingController? passwordController = TextEditingController();

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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColours.naturalColor6),
          ),
          title: Text(
            'Sign up',
            style: getTitle2TextStyle(color: AppColours.naturalColor6),
          ),
        ),
        body: Form(
          key: _formKey,
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColours.semanticColor1,
                  ),
                );
              } else if (state is AuthSuccess) {
                context.pushAndRemoveUntil(MainScreen());
              } else if (state is AuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Loading...'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColours.primaryColor2,
                  ),
                );
              }
            },
            builder: (context, state) {
              var cubit = context.read<AuthCubit>();
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
                              'Welcome to us,',
                              style: getTitle1TextStyle(
                                color: AppColours.primaryColor1,
                              ),
                            ),
                            Text(
                              'Hello there, create New account',
                              style: getCaption2TextStyle(),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Image.asset('assets/images/Register.png'),
                            ),
                            const SizedBox(height: 20),
                            InputFieldWidget(
                              hint: 'Full Name',
                              keyboardType: TextInputType.name,
                              controller: nameController,
                            ),
                            const SizedBox(height: 20),
                            InputFieldWidget(
                              hint: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                            ),
                            const SizedBox(height: 20),
                            InputFieldWidget(
                              hint: 'Password',
                              keyboardType: TextInputType.number,
                              controller: passwordController,
                              isPassword: true,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: agreed,
                                  onChanged: (value) {
                                    setState(() {
                                      agreed = value!;
                                    });
                                  },
                                  activeColor: AppColours.primaryColor1,
                                ),
                                Text(
                                  'I agree to the',
                                  style: getCaption2TextStyle(),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'terms and conditions',
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
                                if (_formKey.currentState!.validate() &&
                                    agreed) {
                                  cubit.register(
                                    nameController!.text.trim(),
                                    emailController!.text.trim(),
                                    passwordController!.text.trim(),
                                  );
                                }
                              },
                              text: 'Sign up',
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: getCaption2TextStyle(),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pushReplacement(LoginScreen());
                                  },
                                  child: Text(
                                    'Sign In',
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
