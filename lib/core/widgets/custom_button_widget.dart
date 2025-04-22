import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibank/core/utils/appcolour.dart';
import 'package:ibank/core/utils/text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.bgcolor,
    this.textColor,
  });
  final String text;
  final Function? onPressed;
  final Color? bgcolor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor ?? AppColours.primaryColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: getBody1TextStyle(
            color: textColor ?? AppColours.naturalColor6,
          ),
        ),
      ),
    );
  }
}
