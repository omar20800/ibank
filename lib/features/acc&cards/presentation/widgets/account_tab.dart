import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/model/user_model.dart';
import 'package:ibank/core/service/local_helper.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/picture_widget.dart';

class AccountsTab extends StatelessWidget {
  AccountsTab({super.key});
  final UserModel? user = AppLocalStorage.getUser();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PictureWidget(width: 100.w, height: 100.h),
        Text(
          '${user?.name?.toUpperCase()}',
          style: getTitle3TextStyle(color: AppColours.primaryColor1),
        ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColours.naturalColor6,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [getDefaultBoxShadow2()],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'email: ${user?.email}',
                style: getBody1TextStyle(color: AppColours.primaryColor1),
              ),
              SizedBox(height: 10.h),
              Text(
                'phone: ${user?.phoneNumber ?? 'No phone number'}',
                style: getBody1TextStyle(color: AppColours.primaryColor1),
              ),
              SizedBox(height: 10.h),
              Text(
                'balance: ${user?.balance}\$',
                style: getBody1TextStyle(color: AppColours.primaryColor1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
