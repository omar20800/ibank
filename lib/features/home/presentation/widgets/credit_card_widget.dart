import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/home/presentation/widgets/serial_number_widget.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    this.serialnumber = '',
    this.username = '',
    this.balance = 0.0,
  });
  final String username;
  final String serialnumber;
  final double balance;

  @override
  Widget build(BuildContext context) {
    if (serialnumber.isEmpty == false) {
      return Container(
        width: double.infinity,
        height: 250.h,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/${getcardtype(serialnumber)}.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getTitle2TextStyle(color: AppColours.naturalColor6),
              ),
            ),
            Text(
              getcardtype(serialnumber)!.toUpperCase(),
              style: getBody1TextStyle(color: AppColours.naturalColor6),
            ),
            SizedBox(height: 20.h),
            SerialNumberWidget(serialNumber: serialnumber),
            SizedBox(height: 10.h),
            Text(
              '\$$balance',
              style: getTitle2TextStyle(color: AppColours.naturalColor6),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 250.h,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/empty.png'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      );
    }
  }

  String? getcardtype(String cardnumber) {
    if (cardnumber.startsWith('4')) {
      return 'visa';
    } else if (cardnumber.startsWith('5') || cardnumber.startsWith('2')) {
      return 'mastercard';
    } else if (cardnumber.startsWith('3')) {
      return 'american express';
    } else if (cardnumber.startsWith('6')) {
      return 'discover';
    } else {
      return null;
    }
  }
}
