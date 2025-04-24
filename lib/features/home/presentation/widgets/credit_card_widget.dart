import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      padding: EdgeInsets.symmetric(
        vertical: 40.h,
        horizontal: 35.w,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/visa.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Pedri Gonzalez',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getTitle2TextStyle(
                color: AppColours.naturalColor6,
              ),
            ),
          ),
          Text(
            'Amazon Platinium',
            style: getBody1TextStyle(
              color: AppColours.naturalColor6,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                '5555',
                style: getBody1TextStyle(
                  color: AppColours.naturalColor6,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '5555',
                style: getBody1TextStyle(
                  color: AppColours.naturalColor6,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '5555',
                style: getBody1TextStyle(
                  color: AppColours.naturalColor6,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '5555',
                style: getBody1TextStyle(
                  color: AppColours.naturalColor6,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            '\$3.469.52',
            style: getTitle2TextStyle(
              color: AppColours.naturalColor6,
            ),
          ),
        ],
      ),
    );
  }
}
