import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/extentions/extenstions.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/dialogs.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/picture_widget.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ibank/features/auth/presentation/cubit/auth_states.dart';
import 'package:ibank/features/settings/presentation/widgets/settings_list_widget.dart';
import 'package:ibank/features/auth/presentation/screens/welcome/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final UserModel user = AppLocalStorage.getUser()!;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthError) {
            context.pop();
            Dialogs.showErrorDialog(context, state.errorMessage);
          } else if (state is AuthSuccess) {
            context.pop();
            context.pushAndRemoveUntil(WelcomeScreen());
          } else if (state is AuthLoading) {
            Dialogs.showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.primaryColor1,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColours.primaryColor1,
              centerTitle: true,
              title: Text(
                'Settings',
                style: getTitle2TextStyle(color: AppColours.naturalColor6),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    context.read<AuthCubit>().logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: AppColours.naturalColor6,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
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
                      children: [
                        SizedBox(height: 80.h),
                        Text(
                          '${user.name}',
                          style: getTitle3TextStyle(
                            color: AppColours.primaryColor1,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        SettingsListWidget(),
                      ],
                    ),
                  ),
                ),
                PictureWidget(
                  imageURL: user.imageUrl,
                  width: 100.w,
                  height: 100.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
