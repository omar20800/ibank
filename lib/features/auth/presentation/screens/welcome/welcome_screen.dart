import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/service/auth_service.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/custom_button_widget.dart';
import 'package:ibank/features/auth/presentation/auth_constants.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/auth/presentation/screens/login/login_screen.dart';
import 'package:ibank/features/auth/presentation/screens/register/register_screen.dart';
import 'package:ibank/features/main/presentation/screens/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: DoubleTapToExit(
        snackBar: const SnackBar(
          content: Text(AuthConstants.doubletaptoexit),
          duration: Duration(seconds: 1),
          backgroundColor: AppColours.semanticColor1,
        ),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) async {
            if (state is AuthError) {
              context.pop();
              Dialogs.showErrorSnackbar(context, state.errorMessage);
              context.pushTo(LoginScreen());
            } else if (state is AuthSuccess) {
              context.pop();
              context.pushTo(MainScreen());
            } else if (state is AuthLoading) {
              Dialogs.showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(backgroundColor: AppColours.primaryColor1),
              backgroundColor: AppColours.primaryColor1,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AuthConstants.welcometitle,
                        style: getTitle1TextStyle(
                          color: AppColours.naturalColor6,
                        ),
                      ),
                      Text(
                        AuthConstants.welcomesubtitle,
                        style: getTitle3TextStyle(
                          color: AppColours.naturalColor6,
                        ),
                      ),
                      Spacer(),
                      CustomButtonWidget(
                        text: AuthConstants.signinbutton,
                        bgcolor: AppColours.primaryColor2,
                        textColor: AppColours.naturalColor6,
                        onPressed: () async {
                          final token = AppLocalStorage.getToken();
                          final user = AppLocalStorage.getUser();
                          if (token != null) {
                            final result = await showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text('Biometric Login'),
                                    content: Text('Are you ${user?.name}'),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, false),
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context, true),
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                            );
                            if (result == true) {
                              final isSupported =
                                  await AuthService().checkBiometricSupport();
                              if (isSupported) {
                                final authenticated = await AuthService()
                                    .authenticateWithBiometrics(
                                      'Authenticate to login',
                                    );
                                if (authenticated) {
                                  context.read<AuthCubit>().getUser();
                                } else {
                                  context.pushTo(LoginScreen());
                                }
                              } else {
                                context.pushTo(LoginScreen());
                              }
                            } else {
                              context.pushTo(LoginScreen());
                            }
                          } else {
                            context.pushTo(LoginScreen());
                          }
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
            );
          },
        ),
      ),
    );
  }
}
