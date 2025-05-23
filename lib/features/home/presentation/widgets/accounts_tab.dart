import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/box_shadow.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/core/widgets/picture_widget.dart';

class AccountsTab extends StatelessWidget {
  const AccountsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PictureWidget(width: 100.w, height: 100.h),
        Text(
          'Pedri Gonzales',
          style: getTitle3TextStyle(color: AppColours.primaryColor1),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 110.h,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [getDefaultBoxShadow()],
                  color: AppColours.naturalColor6,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Account ${index + 1}',
                            style: getTitle3TextStyle(),
                          ),
                          Spacer(),
                          Text('1900 8988 1234', style: getBody1TextStyle()),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Available Balance:',
                            style: getCaption2TextStyle(
                              color: AppColours.naturalColor3,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\$${(index + 1) * 1000}',
                            style: getBody1TextStyle(
                              color: AppColours.primaryColor1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Branch:',
                            style: getCaption2TextStyle(
                              color: AppColours.naturalColor3,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'New York',
                            style: getBody1TextStyle(
                              color: AppColours.primaryColor1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}
